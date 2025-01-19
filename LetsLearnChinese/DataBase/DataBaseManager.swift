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
}
