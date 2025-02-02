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
    var body: some View {
        ZStack {
            DefaultBackground()
            ScrollView {
                VStack (alignment: .leading, spacing: 10) {
                    
                    NavigationLink(destination: AllCharView()){
                        ZStack {
                            Rectangle()
                                .fill(Color.buttonEdge)
                                .frame(height: 50)
                                .cornerRadius(10)
                            
                            Rectangle()
                                .fill(Color.buttonFill)
                                .frame(height: 50 - 10)
                                .cornerRadius(10)
                                .padding(.all, 4)
                            
                            
                            Text("To all Characters")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .font(.custom("InknutAntiqua-Bold", size: UIScreen.main.bounds.width * 0.08 - 5))
                                .lineLimit(1)
                        } // z
                    } // navlink
                    .padding()
                    .padding(.bottom, -25)

                    
                    ForEach(units, id: \.id) { unit in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                Text("\(unit.id):  \(unit.nameEnglish)")
                                    .foregroundStyle(.accent)
                                Spacer()
                                Text("\(unit.nameChinese) \(unit.namePinyin)")
                                    .foregroundStyle(.accent)
                                Text("Level: \(unit.level_id) Part: \(unit.level_part)")
                                    .foregroundStyle(.accent)
                            } //h
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        } // h scroll
                    } // for each unit in units
                    
                } // v
            } // scrollview
            .padding(.bottom, 1)
            .onAppear {
                loadUnits()
            } // onAppear
            
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
} // struct ViewByUnit

struct Unit: Identifiable {
    let id: Int
    let nameEnglish: String
    let nameChinese: String
    let namePinyin: String
    let level_id: Int
    let level_part: Int
}

#Preview {
    ViewByUnit()
}
