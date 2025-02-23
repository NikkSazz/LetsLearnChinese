//
//  AllChar.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/21/25.
//

import SQLite3
import Foundation

func loadAllCharacters() -> [Character] {
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

func textFeildCharacterSQL(of text: String) -> [Character]? {
    if text == "" {
        return nil
    }
    
    // Placeholder
    let characters: [Character] = [
        Character(id: 1, chinese: "你", english: "you", pinyin: "nǐ", unit_id: 1),
        Character(id: 2, chinese: "好", english: "good", pinyin: "hǎo", unit_id: 1),
        Character(id: 3, chinese: "学", english: "study", pinyin: "xué", unit_id: 2),
        Character(id: 4, chinese: "习", english: "practice", pinyin: "xí", unit_id: 2),
        Character(id: 5, chinese: "我", english: "I", pinyin: "wǒ", unit_id: 1),
        Character(id: 6, chinese: "是", english: "am/is/are", pinyin: "shì", unit_id: 3),
        Character(id: 7, chinese: "的", english: "of", pinyin: "de", unit_id: 3),
        Character(id: 8, chinese: "汉", english: "Chinese", pinyin: "hàn", unit_id: 4),
        Character(id: 9, chinese: "语", english: "language", pinyin: "yǔ", unit_id: 4),
        Character(id: 10, chinese: "天", english: "sky/day", pinyin: "tiān", unit_id: 5)
    ]
    return characters
    // Placeholder

}
