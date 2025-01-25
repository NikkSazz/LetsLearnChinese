//
//  SelectUnitsView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/24/25.
//

import SwiftUI

struct SelectUnitsView: View {
    var title: String = "Let's Learn Chinese"
    var subtitle: String = "Select Units"
    
    let levels = [
            ("Level 1", ["Unit 1.1", "Unit 1.2", "Unit 1.3", "Unit 1.4", "Unit 1.5"]),
            ("Level 2", ["Unit 2.1", "Unit 2.2", "Unit 2.3", "Unit 2.4", "Unit 2.5"]),
            // Add more levels as needed
        ]
        
        @State private var selectedUnits: Set<String> = []
    
    var body: some View {
        ZStack {
            
            DefaultBackground()
            
            VStack {
                
                TopBar(title: title, subtitle: subtitle)
                    .frame(alignment: .top)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(levels, id: \.0) { level in
                            VStack {
                                // Large rectangle for the level
                                Button(action: {
                                    // Select all units for this level
                                    level.1.forEach { selectedUnits.insert($0) }
                                }) {
                                    VStack {
                                        Text(level.0) // Level number at the top
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.blue.opacity(0.4))
                                            )
                                        
                                        // Horizontal row of unit buttons inside the rectangle
                                        HStack(spacing: 10) {
                                            ForEach(level.1, id: \.self) { unit in
                                                Button(action: {
                                                    if selectedUnits.contains(unit) {
                                                        selectedUnits.remove(unit) // Deselect if already selected
                                                    } else {
                                                        selectedUnits.insert(unit) // Select the unit
                                                    }
                                                }) {
                                                    Text(unit)
                                                        .font(.subheadline)
                                                        .padding(10)
                                                        .frame(maxWidth: .infinity)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 5)
                                                                .fill(selectedUnits.contains(unit) ? Color.green : Color.gray.opacity(0.3))
                                                        )
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                            }
                                        }
                                    }
                                    .padding()
                                }
                                .buttonStyle(PlainButtonStyle()) // Disable default button style
                            }
                        }
                    }
                    .padding()
                }
                
                
            } // v
            .frame(maxHeight: .infinity, alignment: .top)
        } // z
    } // view body
} // view struct

#Preview {
    SelectUnitsView()
}
