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
            Text("Hello")
            
            Button("Press me to print random character in unit 1"){
                // Example usage
                let randomCharacter = DataBaseManager.shared.getRandomCharacter(fromUnits: [1])
                if let randomCharacter = randomCharacter {
                    print(randomCharacter)
                } else {
                    print("No character found.")
                }

            }
            
            Button("Press me to print random character in unit 2"){
                let randomCharacter = DataBaseManager.shared.getRandomCharacter(fromUnits: [2])
                if let randomCharacter = randomCharacter {
                    print(randomCharacter)
                } else {
                    print("No character found.")
                }
            }
            
            Button("Press me to print random character in unit 3"){
                let randomCharacter = DataBaseManager.shared.getRandomCharacter(fromUnits: [3])
                if let randomCharacter = randomCharacter {
                    print(randomCharacter)
                } else {
                    print("No character found.")
                }
            }
        }
        
    }
}
