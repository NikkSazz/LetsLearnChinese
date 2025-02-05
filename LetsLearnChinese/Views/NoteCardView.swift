//
//  NoteCardView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/29/25.
//

import SwiftUI
import SQLite3

struct NoteCardView: View {
    
    @Binding var selectedUnits: Set<String>    
    @State private var isFlipped = false
    @State private var character: Character = Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn")
    
    var body: some View {
        let animationDuration = 0.5
        ZStack{
            DefaultBackground()
                
            VStack {
                TopBar(title: "NoteCards", subtitle: "学习")
                
                Spacer()
                
                ZStack {
                    
                    if isFlipped {
                        // Back side of the card
                        CardBack()
                    } else {
                        // Front side of the card
                        CardFront()
                    }
                } // z
                .frame(width: .infinity, height: 300) // Adjust size as needed
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
                
                HStack {
                    Button {
                        character = fetchRandomCharacter(from: selectedUnits)
                        print("Character: \(character.chinese), English: \(character.english)")
                    } label: {
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.buttonFill.opacity(0.75))
                            HStack{
                                Image(systemName: "arrow.right")
                                Text("Next Random Char")
                            } // H
                            .foregroundStyle(.black)
                        } // Z
                        .padding(.horizontal, 50)
                        .frame(height: 50)
                    } // button label
                } // H

                
                ScrollView {
                    Text("Selected Units:")
                        .font(.title)
                        .foregroundStyle(.black.opacity(0.75))
                    ForEach(Array(selectedUnits), id: \.self) { level in
                        Text(level)
                            .foregroundStyle(.accent)
                    }
                }
                
            } // v
            .padding(.bottom, 1)
                
        }//z
        .onAppear(){
            character = fetchRandomCharacter(from: selectedUnits)
        }
        
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

func fetchRandomCharacter(from selectedUnits: Set<String>) -> Character {
    let error = Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn")
    
    guard let dbPath = Bundle.main.path(forResource: "llcdb", ofType: "sqlite") else {
        print("Database not found")
        return error
    } // guard dbPath
    
    var db: OpaquePointer?
    if sqlite3_open(dbPath, &db) == SQLITE_OK {
        defer { sqlite3_close(db) }
        
        // Convert the selected units to a comma-separated string
        let unitsList = selectedUnits.joined(separator: ",")
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
                .font(.system(size: 65))
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
    NoteCardView(selectedUnits: .constant(["Greetings", "Family", "Dates and Time", "Hobbies", "Visiting Friends", "Appointments"]))
}
