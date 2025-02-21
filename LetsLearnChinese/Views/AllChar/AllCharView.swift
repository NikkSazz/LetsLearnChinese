//
//  AllCharView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/31/25.
//

import SwiftUI
import SQLite3

struct AllCharView: View {
    
    @State private var inputText: String = ""
    
    var body: some View {
        let characters: [Character] = loadAllCharacters()
        
        ZStack{
            DefaultBackground()
            VStack {
                TopBar(title: "Character List", subtitle: "汉字表")
                
                
                CustomTextFeild(inputText: $inputText)
                
                HStack {
                    Text("Chinese")
                    Spacer()
                    Text("English")
                    Spacer()
                    Text("Pinyin")
                }
                .padding(.horizontal, 30)
                .font(.custom("InknutAntiqua-Bold", size: 22))
                .shadow(radius: 2)
                .foregroundStyle(Color.accentColor)
                .frame(height: 30)
                
                DividerStyle().opacity(0.2)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        
                        ForEach(characters, id: \ .id) { character in
                            CharacterTriple(character: character)
                        } // for each
                    } //v
                    Spacer(minLength: 25)
                } // scroll
                .padding(.bottom, 1)
            } // v
        } //Z Stack
    }//body
    
    private func loadAllCharacters() -> [Character] {
        guard let dbPath = Bundle.main.path(forResource: "llcdb", ofType: "sqlite") else {
            print("Database not found")
            return []
        } // guard dbPath
        
        var db: OpaquePointer?
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            defer { sqlite3_close(db) }

            let query = "SELECT chinese, english, pinyin, id FROM Characters"
            var statement: OpaquePointer?

            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {

                var fetchedCharacters: [Character] = []

                while sqlite3_step(statement) == SQLITE_ROW {
                    let chinese = String(cString: sqlite3_column_text(statement, 0))
                    let english = String(cString: sqlite3_column_text(statement, 1))
                    let pinyin = String(cString: sqlite3_column_text(statement, 2))
                    let id = Int(sqlite3_column_int(statement, 3))

                    let character = Character(id: id, chinese: chinese, english: english, pinyin: pinyin)
//                    print("\t\(character.id)\t\(character.chinese)\t\(character.english)\t\(character.pinyin)")
                    fetchedCharacters.append(character)
                }

                sqlite3_finalize(statement)
                return fetchedCharacters
            }
        }
        return []
    }//loadCharacters func
} // allcharview struct

struct CustomTextFeild: View {
    @Binding var inputText: String
//    private let characterLimit = 20
    
    var body: some View {
        HStack {
            TextField("Search Chinese, English, or Pinyin ...", text: $inputText)
                .padding()
//                .padding(.horizontal)
                .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
            
            // Clear button
            Button(action: {
                inputText = "" // Clear the text
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.buttonEdge.opacity(0.75))
//                    .padding()
            }
            .frame(width: 20)
            .padding(.trailing, 16)
        } // z
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.accentColor.opacity(0.8), lineWidth: 3))
        .padding()
        
        Text(inputText)
            .lineLimit(1)
            .font(.body)
            .foregroundColor(.accent)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.black)
            .cornerRadius(10)
            .padding(.horizontal)


    }
}

struct CharacterTriple: View {
    var character: Character
    var body: some View {
        VStack{
            HStack {
                Text("\(character.chinese)")
                    .font(.system(size: 22))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(character.english)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(character.pinyin)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 50)
            .padding(.top, 5) // makes more symmetry
            .font(.subheadline)
            .foregroundStyle(Color.accentColor)
            
            DividerStyle().opacity(0.2)
        }//v
    }
}

#Preview {
    AllCharView()
}
