//
//  ViewByUnit.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/30/25.
//

import SwiftUI
import SQLite3

struct ViewByUnit: View {
    
    @State private var units: [Unit] = []
    @State private var expandedUnitID: Int? = nil // selects unit, or nil for character presentation
    @State private var characters: [Character] = [] // Holds characters for the selected unit

    var body: some View {
        ZStack {
            DefaultBackground()
            VStack{
                TopBar(title: "View By Units", subtitle: "Dictionary")
                ScrollView {
                    VStack (alignment: .leading, spacing: 10) {
                        
                        Spacer(minLength: 10)
                        
                        ForEach(units, id: \.id) { unit in
                            
                            Button(action: {
                                withAnimation {
                                    if expandedUnitID == unit.id {
                                        expandedUnitID = nil
                                        characters = [] // Clear characters when collapsing
                                    } else {
                                        expandedUnitID = unit.id
                                        loadCharacters(for: unit.id) // Load characters for selected unit
                                    }
                                }
                            }) { // buton action
                                HStack() {
                                    Text("\(unit.id)")
                                    Text("\(unit.nameEnglish)")
                                        .padding(.leading)
                                    
                                    Spacer() // fills width to infinity
                                    
                                    VStack(alignment: .trailing) {
                                        Text("\(unit.nameChinese)")
                                        Text("\(unit.namePinyin)")
                                    }
                                    .multilineTextAlignment(.trailing)
                                    
                                } // h
                                .foregroundStyle(.accent)
                                .frame(height: 50)
                                .padding(.horizontal, 30) // inner padding
                                .padding(.vertical, 2)
                                .background(expandedUnitID == unit.id ?
                                            Color.black.opacity(0.4) : Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .padding(.horizontal, 30) // outer padding
                            } // button label
                            
                            // Expanded Content
                            if expandedUnitID == unit.id {
                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    HStack {
                                        Text("Chinese")
                                        Spacer()
                                        Text("English")
                                        Spacer()
                                        Text("Pinyin")
                                    } // top HStack
                                    .padding(.horizontal, 25)
                                    .font(.custom("InknutAntiqua-Bold", size: 20))
                                    .shadow(radius: 2)
                                    .foregroundStyle(Color.accentColor)
                                    
                                    DividerStyle().opacity(0.2)
                                    
                                    ForEach(characters, id: \ .id) { character in
                                        NavigationLink(destination: DictionarySingleCharacterView(character: character)) {
                                                CharacterTriple(character: character)
                                                .foregroundStyle(Color.accentColor)
                                        } // navlink to dictionary
                                    } // for each
                                } //v
                                .transition(.opacity.combined(with: .move(edge: .trailing)))
                            } // if expanded id
                            
                        } // for each unit in units
                        
                    } // v
                    Spacer(minLength: 50)
                } // scrollview
                .padding(.bottom, 1)
                .onAppear {
                    loadUnits()
                } // onAppear
            }// v
        } // z
    } // body
    
    private func loadUnits() {
        guard let dbPath = Bundle.main.path(forResource: "llcdb", ofType: "sqlite") else {
            print("Database not found")
            return
        }
//        let dbPath = "llcdb.sqlite"
        
        // Open Path
        var db: OpaquePointer?
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            defer { sqlite3_close(db) }
            
            let query = "SELECT * FROM Units"
            var statement: OpaquePointer?
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                var fetchedUnits: [Unit] = []
                
                while sqlite3_step(statement) == SQLITE_ROW {
                    let id = sqlite3_column_int(statement, 0)
                    let nC = String(cString: sqlite3_column_text(statement, 1))
                    let nE = String(cString: sqlite3_column_text(statement, 2))
                    let nP = String(cString: sqlite3_column_text(statement, 3))
                    let lid = Int(sqlite3_column_int(statement, 4))
                    let lpt = Int(sqlite3_column_int(statement, 5))

                   let unit = Unit(
                       id: Int(id),
                       nameEnglish: nE,
                       nameChinese: nC,
                       namePinyin: nP,
                       level_id: lid,
                       level_part: lpt
                   )

                   fetchedUnits.append(unit)
               } // while
                
                sqlite3_finalize(statement)
                units = fetchedUnits
                
            } // ok query
            else { print("Failed to open Table") }
        } // open path
        
    } // loadUnits func
    
    private func loadCharacters(for unitID: Int) {
        guard let dbPath = Bundle.main.path(forResource: "llcdb", ofType: "sqlite") else {
            print("Database not found")
            return
        }

        var db: OpaquePointer?
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            defer { sqlite3_close(db) }

            let query = "SELECT * FROM Characters WHERE unit_id = ?"
            var statement: OpaquePointer?

            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_int(statement, 1, Int32(unitID)) // Bind the unit ID to the query

                var fetchedCharacters: [Character] = []

                while sqlite3_step(statement) == SQLITE_ROW {
                    let id = Int(sqlite3_column_int(statement, 0))
                    let chinese = String(cString: sqlite3_column_text(statement, 1))
                    let english = String(cString: sqlite3_column_text(statement, 2))
                    let pinyin = String(cString: sqlite3_column_text(statement, 3))
                    let unitID = Int(sqlite3_column_int(statement, 4))
                    let type = String(cString: sqlite3_column_text(statement, 5))

                    let character = Character(id: id, chinese: chinese, english: english, pinyin: pinyin, unit_id: unitID, type: type)
                    fetchedCharacters.append(character)
                }

                sqlite3_finalize(statement)
                characters = fetchedCharacters
            } else {
                print("Failed to prepare statement")
            }
        } else {
            print("Failed to open database")
        }
    }

    
} // struct ViewByUnit

#Preview {
    ViewByUnit()
}
