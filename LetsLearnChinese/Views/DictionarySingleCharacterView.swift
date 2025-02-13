//
//  DictionarySingleCharacterView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/5/25.
//

import SwiftUI
import SQLite3

struct DictionarySingleCharacterView: View {
    
    let character: Character
    
    @State private var expandedChar: String? = nil
    @State private var expandedList: [Character] = []
    
    
    var body: some View {
        ZStack{
            DefaultBackground()
            
            VStack(spacing: 10) {
                    
                
                coolDictText(character)
                
                moreWordsWith()
                
                ForEach(character.chinese.filter { $0 != "." }.map { String($0) }, id: \.self) { char in
                    Button {
                        print("Button with \(char) pressed")
                        withAnimation {
                            expandedChar = expandedChar == char ? nil : char
                            updateExpandedList(for: char, not: character.chinese)
                        } // withAnimation
                    } label: {
                        
                        HStack {
                            Text("More Words with")
                            
                            Text(char)
                                .font(.system(size: 30))
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 2)
                        .background(/*expandedEachChar &&*/
                                    expandedChar == char ?
                                    Color.black.opacity(0.4) : Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        
                        Spacer() // move text to leading
                        
                    } // button label

                    if expandedChar == char {
                        VStack{
                            if expandedList.isEmpty {
                                Text("No other words with \(char)")
                            }
                            
                            ForEach(expandedList, id: \.id) { character in
                                CharacterTriple(character: character)
                            } // For each in expandedList
                        } // V
                        .transition(.opacity.combined(with: .move(edge: .trailing)))
                    } // if expandedChar == char
                    
                } // for each char in Dictionary Character
                
                
//                Text("Expanded \(expandedChar ?? "∅")")
//                    .font(.system(size: 30))
                
            } // v
            .foregroundStyle(.accent)
        } // Z
    } // body some view
    
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
    
} // dictionary Signle Character View struct

struct moreWordsWith: View {
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

struct coolDictText: View {
    let character: Character
    
    init(_ character: Character) {
        self.character = character
    } // makes things cleaner while coding
    
    var body: some View {
        Text(character.chinese)
            .font(.system(size: 65))
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.cyan.opacity(0.2), .purple.opacity(0.2)]),
                               startPoint: .bottomLeading,
                               endPoint: .topTrailing)
                .cornerRadius(10)
            ) // background
            .shadow(color: .black, radius: 3, x: -5, y: 5)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
//    MainMenu()
//    DictionarySingleCharacterView(character: Character(id: 9, chinese: "小姐", english: "miss", pinyin: "xiaojie"))
    DictionarySingleCharacterView(character: Character(id: 196, chinese: "图书馆", english: "library", pinyin: "túshūguǎn"))
}

// 「 你是谁？」《我是俄国人》 二零二五年 二月 十一日
