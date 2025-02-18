//
//  NoteCardSQLiteCommands.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/16/25.
//

import SQLite3
import Foundation

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

func getAllCharacters(from selectedUnits: Set<Int>) -> [Character] {
    guard let dbPath = Bundle.main.path(forResource: "llcdb", ofType: "sqlite") else {
        print("Database not found")
        return []
    }
    
    var db: OpaquePointer?
    if sqlite3_open(dbPath, &db) != SQLITE_OK {
        print("Failed to open database")
        return []
    }
    defer {
        sqlite3_close(db)
    }
    
    
    let unitsString = selectedUnits.map { "\($0)" }.joined(separator: ",")
    let query = """
    SELECT id, chinese, english, pinyin, unit_id
    FROM Characters
    WHERE unit_id IN (\(unitsString))
    ORDER BY RANDOM();
    """
    
    var statement: OpaquePointer?
    if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
        let errorMsg = String(cString: sqlite3_errmsg(db))
        print("Failed to prepare query: \(errorMsg)")
        return []
    }
    defer {
        sqlite3_finalize(statement)
    }
    
    
    var characters: [Character] = []
    
    while sqlite3_step(statement) == SQLITE_ROW {
        let id = Int(sqlite3_column_int(statement, 0))
        let chinese = String(cString: sqlite3_column_text(statement, 1))
        let english = String(cString: sqlite3_column_text(statement, 2))
        let pinyin = String(cString: sqlite3_column_text(statement, 3))
        let unit_id = sqlite3_column_type(statement, 4) == SQLITE_NULL
            ? nil
            : Int(sqlite3_column_int(statement, 4))
        
        let character = Character(id: id, chinese: chinese, english: english, pinyin: pinyin, unit_id: unit_id)
        characters.append(character)
    }
    
    return characters
}
