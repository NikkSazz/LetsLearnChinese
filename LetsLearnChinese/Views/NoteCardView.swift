//
//  NoteCardView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/29/25.
//

import SwiftUI
import SQLite3

struct NoteCardView: View {
    
    /// Binding given by SelectUnits() gets random character from selectedUnits
    @Binding var selectedUnits: Set<Int>
    
    /// Current Character used in the NoteCard
    @State var character: Character = Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn")
    
    /// Stack to ctrl+z back to previous Character
    @State var previousCharStack: [Character] = []
    
    /// Bottom button to hide the Character's Unit and ID
    @State var showUnit = false
    
    var body: some View {
        let animationDuration = 0.3
        ZStack{
            DefaultBackground()
                
            VStack {
                TopBar(title: "NoteCards", subtitle: "学习")
                
                Spacer()
                
                NoteCard(character: character, animationDuration: animationDuration)
                
                
                Button { // next random char
                    previousCharStack.append(character)
                    character = fetchRandomCharacter(from: selectedUnits)
//                    print("Character: \(character.chinese), English: \(character.english)")
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
                } // next rand char button
                
                HStack {
                    
                    NavigationLink (destination: DictionarySingleCharacterView(character: character)){
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.buttonFill.opacity(0.75))
                            HStack{
                                Image(systemName: "book.pages.fill")
                                
                                Text("Go to Dictionary")
                            } // H
                            .foregroundStyle(.black)
                        } // Z
                        .frame(height: 50)
                        .cornerRadius(10)
                    } // Dictionary label
                    
                    Button {
//                        print("Previous Button Pressed")
                        character = previousCharStack.popLast() ?? Character(id: 56, chinese: "没有", english: "Doesnt Have", pinyin: "méi yǒu")
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
                    } // Previous button
                    
                } // H
                .padding(.horizontal)

                
                VStack {
                    Text("Selected Units:")
                        .font(.title)
                        .foregroundStyle(.black.opacity(0.5))
                    HStack {
                        ForEach(Array(selectedUnits).sorted(), id: \.self) { level in
                            Text("\(level)")
                        } // display level for each
                    } // H
                    .foregroundStyle(.accent)
                    Spacer()
                    
                    HStack {
                    
                        Button {
                            showUnit.toggle()
                        } label: {
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(
                                        showUnit ?
                                            .accent :
                                        .buttonFill.opacity(0.75))
                                HStack{
                                    Text(showUnit ? "Hide" : "Show Unit and ID")
//                                    Text("Show Unit") // Old Version
                                } // H
                                .foregroundStyle(.black)
                            } // Z
                            .frame(height: 50)
                            .cornerRadius(10)
                            .padding(.leading, 50)
                            .padding(.trailing, showUnit ? 20 : 50)
                        } // Button ShowUnit
                        if showUnit{
                            if character.unit_id != nil {
                                Text("Unit: \(character.unit_id ?? 0)")
                                    .font(.system(size: 20))
                                    .frame(width: 75, alignment: .leading)
                            }
                            Text("ID: \(character.id)")
                                .frame(width: 75, alignment: .leading)
//                                .padding()
                            Spacer(minLength: 50)
                        }
                        
                    } // H showunit and id
                        .foregroundStyle(.accent)
                    
                    Spacer(minLength: 30)
                    
                } // V View units
                
            } // v
            .padding(.bottom, 1)
                
        }//z
        .onAppear(){
            character = fetchRandomCharacter(from: selectedUnits)
        } // on appear Z
        
    } // body
} // notecardview

struct NoteCard: View {
    var character: Character
    var animationDuration: TimeInterval
    @State private var isFlipped = false
    var body: some View {
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
    }
}

struct CardFront: View {
    var c: Character
    
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
//        print("UnitsList: \(unitsList)")
        
        // SQLite query
        let query = """
      SELECT id, chinese, english, pinyin, unit_id
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
                let uId = Int(sqlite3_column_int(statement, 4))
                
                sqlite3_finalize(statement)
                
                return Character(id: id, chinese: chinese, english: english, pinyin: pinyin, unit_id: uId)
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
    NoteCardView(selectedUnits: .constant([6]))
}
