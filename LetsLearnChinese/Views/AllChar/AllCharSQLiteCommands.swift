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

func searchCharacters(input: String) -> [Character] {
    guard !input.isEmpty,
          let dbPath = Bundle.main.path(forResource: "llcdb", ofType: "sqlite") else {
        return []
    }

    var db: OpaquePointer?
    var results: [Character] = []

    if sqlite3_open(dbPath, &db) == SQLITE_OK {
        defer { sqlite3_close(db) }

        let query = """
        SELECT chinese, english, pinyin, id
        FROM Characters
        WHERE chinese LIKE ? OR english LIKE ? OR pinyin LIKE ?
        """
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, "%\(input)%", -1, nil)
            sqlite3_bind_text(statement, 2, "%\(input)%", -1, nil)
            sqlite3_bind_text(statement, 3, "%\(input)%", -1, nil)

            while sqlite3_step(statement) == SQLITE_ROW {
                let chinese = String(cString: sqlite3_column_text(statement, 0))
                let english = String(cString: sqlite3_column_text(statement, 1))
                let pinyin = String(cString: sqlite3_column_text(statement, 2))
                let id = Int(sqlite3_column_int(statement, 3))

                results.append(Character(id: id, chinese: chinese, english: english, pinyin: pinyin))
            }
            sqlite3_finalize(statement)
        }
    }
    return results
}

func textFeildCharacterSQL(of text: String) -> [Character]? {
    if text == "" {
        return nil
    }
    
    // Placeholder
    let characters: [Character] = [
        Character(id: 1, chinese: "А", english: "you", pinyin: "nǐ", unit_id: 1),
        Character(id: 2, chinese: "Б", english: "good", pinyin: "hǎo", unit_id: 1),
        Character(id: 3, chinese: "В", english: "study", pinyin: "xué", unit_id: 2),
        Character(id: 4, chinese: "Г", english: "practice", pinyin: "xí", unit_id: 2),
        Character(id: 5, chinese: "Д", english: "I", pinyin: "wǒ", unit_id: 1),
        Character(id: 6, chinese: "Е", english: "am/is/are", pinyin: "shì", unit_id: 3),
        Character(id: 7, chinese: "Ё", english: "of", pinyin: "de", unit_id: 3),
        Character(id: 8, chinese: "Ж", english: "Chinese", pinyin: "hàn", unit_id: 4),
        Character(id: 9, chinese: "З", english: "language", pinyin: "yǔ", unit_id: 4),
        Character(id: 10,chinese: "И", english: "sky/day", pinyin: "tiān", unit_id: 5)
    ]
    return characters
    // Placeholder

}

func performSearch(text: String, in characters: [Character]) -> [Character]? {
    guard !text.isEmpty else { return nil }
    return characters.filter { $0.chinese.contains(text) || $0.english.contains(text) || $0.pinyin.contains(text) }
}
