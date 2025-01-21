//
//  DataBaseManager.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/19/25.
//

import SQLite3
import Foundation

class DataBaseManager {
    static let shared = DataBaseManager()
    var db: OpaquePointer?
    
    private init() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("ChineseLearningDB.sqlite")

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        } else {
            print("Database created/opened at \(fileURL.path)")
        }
        createTables()
    }
    
    func createTables() {
        
        createTable(query: """
        CREATE TABLE IF NOT EXISTS ChineseCharacter (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            Chinese TEXT NOT NULL,
            Pinyin TEXT NOT NULL,
            English TEXT NOT NULL,
            Unit_ID INTEGER NOT NULL
        );
        """)
        
        createTable(query: """
        CREATE TABLE IF NOT EXISTS UnitID (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            Name TEXT NOT NULL,
            Chinese TEXT NOT NULL,
            Pinyin TEXT NOT NULL,
            Level_ID INTEGER NOT NULL
        );
        """)
        
        createTable(query: """
        CREATE TABLE IF NOT EXISTS LevelID (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            Name TEXT NOT NULL,
            Chinese TEXT NOT NULL,
            Pinyin TEXT NOT NULL
        );
        """)
        
        createTable(query: """
        CREATE TABLE IF NOT EXISTS ExampleSentence (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            Character_ID INTEGER NOT NULL,
            Ex1English TEXT NOT NULL,
            Ex1Pinyin TEXT NOT NULL,
            Ex1Chinese TEXT NOT NULL,
            Ex2English TEXT NOT NULL,
            Ex2Pinyin TEXT NOT NULL,
            Ex2Chinese TEXT NOT NULL
        );
        """)
        
        createTable(query: """
        CREATE TABLE IF NOT EXISTS Statistics (
            Statistics_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            Character_ID INTEGER NOT NULL,
            MultipleChoicePercentage REAL NOT NULL,
            FinalExamPercentage REAL NOT NULL,
            WrittenPercentage REAL NOT NULL,
            NoteCardPercentage REAL NOT NULL
        );
        """)
        
        
    }
    
    private func createTable(query: String) {
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table created successfully")
            } else {
                print("Table could not be created")
            }
        } else {
            print("Table creation preparation failed")
        }
        sqlite3_finalize(statement)
    }
    
    func populateData() {
        // Read data from text files
        let chineseCharacterLines = readFile(fileName: "chinese_character_data")
        let unitIDLines = readFile(fileName: "unit_id_data")
        let levelIDLines = readFile(fileName: "level_id_data")
        let exampleSentenceLines = readFile(fileName: "example_sentence_data")

        // Populate the database for each table
        populateDatabase(lines: chineseCharacterLines, table: "ChineseCharacter")
        populateDatabase(lines: unitIDLines, table: "UnitID")
        populateDatabase(lines: levelIDLines, table: "LevelID")
        populateDatabase(lines: exampleSentenceLines, table: "ExampleSentence")

    }
    
    func readFile(fileName: String) -> [String] {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            print("File not found")
            return []
        }

        do {
            let content = try String(contentsOfFile: filePath, encoding: .utf8)
            return content.components(separatedBy: .newlines).filter { !$0.isEmpty && !$0.starts(with: "#") }
        } catch {
            print("Error reading file: \(error)")
            return []
        }
    }

    func populateDatabase(lines: [String], table: String) {
        for line in lines {
            let components = line.split(separator: "|").map { String($0) }

            if table == "ChineseCharacter" && components.count == 5 { // ChineseCharacter Table
                insertCharacter(chinese: components[1], pinyin: components[2], english: components[3], unitID: Int(components[4])!)
            } else if table == "UnitID" && components.count == 4 { // UnitID Table
                insertUnit(name: components[1], chinese: components[2], pinyin: components[3], levelID: Int(components[4])!)
            } else if table == "LevelID" && components.count == 3 { // LevelID Table
                insertLevel(name: components[1], chinese: components[2], pinyin: components[3])
            } else if table == "ExampleSentence" && components.count == 7 { // ExampleSentence Table
                insertExampleSentence(characterID: Int(components[0])!,
                                       ex1English: components[1], ex1Pinyin: components[2], ex1Chinese: components[3],
                                       ex2English: components[4], ex2Pinyin: components[5], ex2Chinese: components[6])
            }
        }
    }

    func insertCharacter(chinese: String, pinyin: String, english: String, unitID: Int) {
        let query = "INSERT INTO ChineseCharacter (Chinese, Pinyin, English, Unit_ID) VALUES (?, ?, ?, ?);"
        executeInsert(query: query, params: [chinese, pinyin, english, "\(unitID)"])
    }

    func insertUnit(name: String, chinese: String, pinyin: String, levelID: Int) {
        let query = "INSERT INTO UnitID (Name, Chinese, Pinyin, Level_ID) VALUES (?, ?, ?, ?);"
        executeInsert(query: query, params: [name, chinese, pinyin, "\(levelID)"])
    }

    func insertLevel(name: String, chinese: String, pinyin: String) {
        let query = "INSERT INTO LevelID (Name, Chinese, Pinyin) VALUES (?, ?, ?);"
        executeInsert(query: query, params: [name, chinese, pinyin])
    }

    func insertExampleSentence(characterID: Int, ex1English: String, ex1Pinyin: String, ex1Chinese: String, ex2English: String, ex2Pinyin: String, ex2Chinese: String) {
        let query = """
        INSERT INTO ExampleSentence (Character_ID, Ex1English, Ex1Pinyin, Ex1Chinese, Ex2English, Ex2Pinyin, Ex2Chinese)
        VALUES (?, ?, ?, ?, ?, ?, ?);
        """
        executeInsert(query: query, params: ["\(characterID)", ex1English, ex1Pinyin, ex1Chinese, ex2English, ex2Pinyin, ex2Chinese])
    }

    func executeInsert(query: String, params: [String]) {
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(DataBaseManager.shared.db, query, -1, &statement, nil) == SQLITE_OK {
            for (index, param) in params.enumerated() {
                sqlite3_bind_text(statement, Int32(index + 1), param, -1, nil)
            }

            if sqlite3_step(statement) == SQLITE_DONE {
                print("Successfully inserted data")
            } else {
                print("Failed to insert data")
            }
        } else {
            print("Error preparing insert statement")
        }
        sqlite3_finalize(statement)
    }
    
    
    // AYAYA
    // AYAYA
    // AYAYA
    // AYAYA
    
    func getRandomCharacter(fromUnits unitIDs: [Int]) -> String? {
        guard !unitIDs.isEmpty else {
            print("Unit IDs array is empty.")
            return nil
        }
        
        let unitIDList = unitIDs.map { String($0) }.joined(separator: ",")
        
        print("UnitIDLIST: \(unitIDList)")
        
        let query = """
        SELECT Chinese, Pinyin, English
        FROM ChineseCharacter
        WHERE Unit_ID IN (\(unitIDList))
        ORDER BY RANDOM()
        LIMIT 1;
        """
        print("Query: \(query)")  // Add this to see the query being executed

        
        var statement: OpaquePointer?
        var result: String?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                if let chinese = sqlite3_column_text(statement, 0),
                   let pinyin = sqlite3_column_text(statement, 1),
                   let english = sqlite3_column_text(statement, 2) {
                    let chineseText = String(cString: chinese)
                    let pinyinText = String(cString: pinyin)
                    let englishText = String(cString: english)
                    
                    result = "\(chineseText), \(pinyinText), \(englishText)"
                }
            } else {
                print("No data found for the specified unit IDs.")
            }
        } else {
            print("Error preparing query: \(query)")
        }
        
        sqlite3_finalize(statement)
        
        return result
    }

} // class
