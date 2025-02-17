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
    // write code here
    return [Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn"),
            Character(id: 2, chinese: "学校", english: "School", pinyin: "xuéxiào"),
            Character(id: 3, chinese: "医院", english: "Hospital", pinyin: "yīyuàn"),
            Character(id: 4, chinese: "超市", english: "Supermarket", pinyin: "chāoshì"),
            Character(id: 5, chinese: "餐厅", english: "Restaurant", pinyin: "cāntīng"),
            Character(id: 6, chinese: "银行", english: "Bank", pinyin: "yínháng"),
            Character(id: 7, chinese: "公园", english: "Park", pinyin: "gōngyuán"),
            Character(id: 8, chinese: "火车站", english: "Train Station", pinyin: "huǒchēzhàn"),
            Character(id: 9, chinese: "电影院", english: "Cinema", pinyin: "diànyǐngyuàn"),
            Character(id: 10, chinese: "邮局", english: "Post Office", pinyin: "yóujú"),]
}
