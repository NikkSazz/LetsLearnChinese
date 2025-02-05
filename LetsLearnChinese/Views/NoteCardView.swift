//
//  NoteCardView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/29/25.
//

import SwiftUI
import SQLite3

struct NoteCardView: View {
    
    @Binding var selectedUnits: Set<Int>    
    @State private var isFlipped = false
    
    @State var character: Character = Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn")
    @State private var trueRandom = false
    @State var previousChar: [Character] = [Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn"), Character(id: 2, chinese: "学校", english: "School", pinyin: "xuéxiào")]
    
    var body: some View {
        let animationDuration = 0.3
        ZStack{
            DefaultBackground()
                
            VStack {
                TopBar(title: "NoteCards", subtitle: "学习")
                
                Spacer()
                
                ZStack {
                    
                    if isFlipped {
                        // Back side of the card
                        CardBack(c: character)
                    } else {
                        // Front side of the card
                        CardFront(c: character)
                    }
                } // z
                .frame(height: 300)
                .cornerRadius(16)
                .shadow(radius: 5)
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        isFlipped.toggle()
                    }
                } // ontapgesture of z stack
                .padding(.horizontal, 75)
                .padding(.vertical, 30)
                
                
                Button {
                    character = fetchRandomCharacter(from: selectedUnits)
                    print("Character: \(character.chinese), English: \(character.english)")
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(.buttonFill.opacity(0.75))
                        HStack{
                            Image(systemName: "arrowshape.right")
                            Text("Next Random Char")
                        } // H
                        .foregroundStyle(.black)
                    } // Z
                    .frame(height: 50)
                    .cornerRadius(10)
                    .padding(.horizontal)
                } // next rand char button label
                
                HStack {
                    
                    Button {
                        print("Button Pressed")
                        trueRandom = !trueRandom
                    } label: {
                        ZStack{
                            Rectangle()
                                .foregroundStyle(
                                    trueRandom ?
                                        .accent.opacity(0.9) :
                                    .buttonFill.opacity(0.75))
                            HStack{
                                Image(systemName: "arrow.trianglehead.counterclockwise.rotate.90")
                                
                                Text("True Random")
                            } // H
                            .foregroundStyle(.black)
                        } // Z
                        .frame(height: 50)
                        .cornerRadius(10)
                    } // true random button
                    
                    Button {
                        print("Previous Button Pressed")
                        character = previousChar.popLast() ?? Character(id: 1, chinese: "不是", english: "Doesnt Have", pinyin: "BuShi")
                    } label: {
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.buttonFill.opacity(0.75))
                            HStack{
                                Image(systemName: "arrowshape.left")
                                
                                Text("Previous")
                            } // H
                            .foregroundStyle(.black)
                        } // Z
                        .frame(height: 50)
                        .cornerRadius(10)
                    } // true random button
                    
                } // H
                .padding(.horizontal)

                
                ScrollView {
                    Text("Selected Units:")
                        .font(.title)
                        .foregroundStyle(.black.opacity(0.75))
                    ForEach(Array(selectedUnits).sorted(), id: \.self) { level in
                        Text("\(level)")
                            .foregroundStyle(.accent)
                    }
                } // Scroll View
                
                Text("True Random randomly selects a character from the available list, removes it to prevent repeats, and resets the list when all characters have been displayed.")
                    .foregroundStyle(.accent)
                
                Spacer()
                
            } // v
            .padding(.bottom, 1)
                
        }//z
        .onAppear(){
            character = fetchRandomCharacter(from: selectedUnits)
        } // on appear Z
        
    } // body
} // notecardview

struct CardFront: View {
    var c: Character = Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn")
    
    var body: some View {
        Text(c.chinese)
            .font(.system(size: 50))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor.gradient)
            .cornerRadius(16)
    } // view
} // CardFront View

func fetchRandomCharacter(from selectedUnits: Set<Int>) -> Character {
    let error = Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn")
    
    guard let dbPath = Bundle.main.path(forResource: "llcdb", ofType: "sqlite") else {
        print("Database not found")
        return error
    } // guard dbPath
    
    var db: OpaquePointer?
    if sqlite3_open(dbPath, &db) == SQLITE_OK {
        defer { sqlite3_close(db) }
        
        // Convert the selected units to a comma-separated string
        let unitsList = selectedUnits.map { "\($0)" }.joined(separator: ",")
        print("UnitsList: \(unitsList)")
        
        // SQLite query
        let query = """
      SELECT id, chinese, english, pinyin
      FROM Characters
      WHERE unit_id IN (\(unitsList))
      ORDER BY RANDOM()
      LIMIT 1;
      """
        
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let chinese = String(cString: sqlite3_column_text(statement, 1))
                let english = String(cString: sqlite3_column_text(statement, 2))
                let pinyin = String(cString: sqlite3_column_text(statement, 3))
                
                sqlite3_finalize(statement)
                
                return Character(id: id, chinese: chinese, english: english, pinyin: pinyin)
            }
        }
        
        sqlite3_finalize(statement)
    }
    return error
        
} // fetchRandomCharacter Func

struct CardBack: View {
    var c: Character = Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn")
    
    var body: some View {
        
        VStack {
            Text(c.english)
                .padding(.bottom)
                .font(.system(size: 50))
            Text(c.pinyin)
                .font(.system(size: 30))
        }
        .scaleEffect(x: -1, y: 1) // flipped
        .foregroundColor(.accent)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.gradient.opacity(0.5))
        .cornerRadius(16)
    } // body view
} // CardBack View

#Preview {
    NoteCardView(selectedUnits: .constant([6, 4, 2, 3]))
}
