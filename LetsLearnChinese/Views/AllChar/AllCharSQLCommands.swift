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
