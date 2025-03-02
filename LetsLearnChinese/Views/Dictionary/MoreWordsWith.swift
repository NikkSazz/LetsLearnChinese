//
//  NewMoreWordsWith.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/26/25.
//

import SwiftUI
import SQLite3


struct MoreWordsWith: View {
    let fullWord: String
    @Binding var expandedChar: String?
    @Binding var expandedList: [Character]
    
    var body: some View {
        VStack {
            moreWordsWithText()
            
            HStack{

                Spacer()
                ForEach(fullWord.filter { $0 != "." && $0 != "," && $0 != " " }.map { String($0) }, id: \.self) { char in
                    
                    Button(action: {
                        withAnimation{
                            updateExpandedList(for: char, not: fullWord)
                            expandedChar = expandedChar == char ? nil : char
                        }
                    }) {
                        Text("\(char)")
                            .font(.system(size: 40))
                            .foregroundStyle(.black)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 2)
                            .background(expandedChar == char ?
                                        Color.accentColor.opacity(0.9) : Color.gray.opacity(0.2))
                    }
                        .cornerRadius(10)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            
            if expandedChar != nil {
                VStack{
                    if expandedList.isEmpty {
                        Text("No other words with \(expandedChar ?? "Error")")
                    }
                    
                    let characterTripleHeight: CGFloat = 50 // Adjust this to match the height of a CharacterTriple view

                    if expandedList.count > 4 {
                        ScrollView {
                            VStack {
                                ForEach(expandedList, id: \.id) { character in
                                    CharacterTriple(character: character)
                                        .frame(height: characterTripleHeight) // Ensure consistent height
                                }
                            }
                        }
                        .frame(height: characterTripleHeight * 6) // Height for exactly 4 CharacterTriple views
                    } else {
                        VStack {
                            ForEach(expandedList, id: \.id) { character in
                                CharacterTriple(character: character)
                            }
                        }
                    }
                    
                } // V
            } // if expandedChar != nil
            
        } // body
    }
    
    func updateExpandedList(for orderBy_Argument: String, not exclude: String) {
        
        print("for \(orderBy_Argument)\tnot\(exclude)")
        
        expandedList.removeAll()
        
        guard let dbPath = Bundle.main.path(forResource: "llcdb", ofType: "sqlite") else {
            print("Database not found")
            return
        }
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("Unable to open database.")
            return
        }
        defer { sqlite3_close(db) } // runs when the function ends
        
        let query = "SELECT * FROM characters WHERE chinese LIKE ? AND chinese != ? ORDER BY (chinese = ?) DESC"
        
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            print("Failed to prepare statement: \(String(cString: sqlite3_errmsg(db)))")
            return
        }
        defer { sqlite3_finalize(statement) }
        
        let like_Argument = "%" + orderBy_Argument + "%"
        if sqlite3_bind_text(statement, 1, (like_Argument as NSString).utf8String, -1, nil) != SQLITE_OK ||
            sqlite3_bind_text(statement, 2, (exclude as NSString).utf8String, -1, nil) != SQLITE_OK ||
            sqlite3_bind_text(statement, 3, (orderBy_Argument as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Failed to bind argument: \(String(cString: sqlite3_errmsg(db)))")
            return
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = Int(sqlite3_column_int(statement, 0))
            let chinese = String(cString: sqlite3_column_text(statement, 1))
            let english = String(cString: sqlite3_column_text(statement, 2))
            let pinyin = String(cString: sqlite3_column_text(statement, 3))

            let character = Character(id: id, chinese: chinese, english: english, pinyin: pinyin)
            print("Appended \(character.chinese) \(character.english)")
            
            expandedList.append(character)
        }

        
    } // func updateExpandedList
} // struct

struct moreWordsWithText: View {
    var body: some View {
        ZStack{
            
            Text("More words with:")
                .foregroundStyle(.black)
                .offset(x: 2, y: 1)
                .shadow(radius: 1)
            
            Text("More words with:")
                
        }
        .font(.custom("InknutAntiqua-Bold", size: 18))
        .shadow(radius: 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 30)
        .padding(.bottom, -10)
    }
}
