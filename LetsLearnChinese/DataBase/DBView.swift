//
//  DBView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/19/25.
//

import SwiftUI
import SwiftData

struct DBView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            Button("Add Units") {
                let unit1 = Unit(id: 1, name: "Basics")
                let unit2 = Unit(id: 2, name: "Advanced")
                modelContext.insert(unit1)
                modelContext.insert(unit2)
            }
            
            Button("Add Chinese Characters") {
                let character1 = ChineseCharacter(id: 1, character: "你", unitId: 1, english: ["you"])
                let character2 = ChineseCharacter(id: 2, character: "好", unitId: 1, english: ["good"])
                modelContext.insert(character1)
                modelContext.insert(character2)
            }
            
            Button("Fetch Data") {
                do {
                    let fetchDescriptor = FetchDescriptor<Unit>()
                    let units = try modelContext.fetch(fetchDescriptor)
                    for unit in units {
                        print("Unit: \(unit.name) (ID: \(unit.id))")
                    }
                }catch {
                    print("Error fetching data \(error)")
                }
                do {
                    let fetchDescriptor = FetchDescriptor<ChineseCharacter>()
                    let characters = try modelContext.fetch(fetchDescriptor)
                    for character in characters {
                        print("Character: \(character.character), English: \(character.english), UnitID: \(character.unitId)")
                    }
                }   catch {
                    print("Error fetching data \(error)")
                }
            }
            
        }
    }
}
