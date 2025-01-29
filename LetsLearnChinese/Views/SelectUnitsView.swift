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
    var view: AnyView = AnyView(NotImplimentedView())
    
    let levels = [
            ("Level 1 Part 1", ["Greetings", "Family", "Dates and Time", "Hobbies", "Visiting Friends"]),
            ("Level 1 Part 2", ["Appointments", "Studying", "School Life", "Shopping", "Transportation"]),
            ("Level 2 Part 1", ["Thingt", "Thinge", "Another Thing", "Thinga", "Thingggssz"]),
            ("Level 2 Part 2", ["Thing", "Thingz", "Anotherr Thing", "Thinking", "Thinggssz"])
        ]
        
    @State private var selectedUnits: Set<String> = []
    @State private var unitColors: [String: Color] = [:]

    var body: some View {
        ZStack {
            
            DefaultBackground()
            
            VStack {
                
                TopBar(title: title, subtitle: subtitle)
                    .frame(alignment: .top)
                
                
                 
                ScrollView {
                    Text("May use characters, words, and sentences from previous unselected units.")
                        .lineLimit(2)
                        .foregroundStyle(.accent)
                        .padding(.top)
                        .padding(.horizontal, 20)
                   
               
                    Text(":)")
                        .foregroundStyle(.accent)
                    
                    
                    VStack(spacing: 20) {
                        ForEach(levels, id: \.0) { level in
                            VStack {
                                // Large rectangle for the level
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        // Check if all units in the level are already selected
                                        let allSelected = level.1.allSatisfy { selectedUnits.contains($0) }
                                        
                                        if allSelected {
                                            level.1.forEach { selectedUnits.remove($0) }
                                        } else {
                                            level.1.forEach { selectedUnits.insert($0) }
//                                            unitColors[$0] = unitColors[$0] ?? RandomColor()
                                        }
                                    }
                                }) {
                                    VStack {
                                        Text(level.0) // Level number at the top
                                            .font(.custom("InknutAntiqua-Black", size: 20))
                                            .foregroundStyle(.black.opacity(0.8))
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(level.1.allSatisfy { selectedUnits.contains($0) } ? RandomColor() : Color.accent)
                                                    .frame(height: 40)
                                            )
                                            .frame(height: 40)
                                        
                                        // Horizontal ScrollView of unit buttons inside the rectangle
                                        ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(spacing: 10) {
                                                    ForEach(level.1, id: \.self) { unit in
//                                                        unitColors[unit] = RandomColor()
                                                        VStack(spacing: 2) {
                                                            Text("\(unit)") // Unit label
                                                                .foregroundStyle(.white)
                                                            Button(action: {
                                                                if selectedUnits.contains(unit) {
                                                                    selectedUnits.remove(unit) // Deselect if already selected
                                                                } else {
                                                                    selectedUnits.insert(unit) // Select the unit
                                                                    unitColors[unit] = unitColors[unit] ?? RandomColor()
                                                                }
                                                            }) {
                                                                Rectangle()
                                                                    .frame(width: 100, height: 80)
                                                                    .foregroundStyle(selectedUnits.contains(unit) ? (unitColors[unit] ?? Color.accent) : Color.accent) // Use the color from unitColors dictionary
                                                                    .cornerRadius(5)
                                                            }
                                                            .buttonStyle(PlainButtonStyle())
                                                        }
                                                        .padding(.bottom, 10)
                                                        Spacer(minLength: 5)
                                                    }
                                                }
                                                .padding(.horizontal)
                                            }
                                            .background(Color.gray.opacity(0.25))
                                            .frame(maxWidth: .infinity)
                                        }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding()

                    
                    Text(":)")
                        .foregroundStyle(.accent)
                } // scroll
                
                NavigationLink(destination: view){
                    Rectangle()
                        .frame(height: 50)
                        .padding(.bottom)
                        .padding(.horizontal, 15)
                        .padding(.top, -5)
                        .foregroundStyle(.blue)
                }
            } // v
            .frame(maxHeight: .infinity, alignment: .top)
            
        } // z
    } // view body
} // view struct

func RandomColor() -> Color {
    let red = Double.random(in: 0.1...0.75)
    let green = Double.random(in: 0.1...0.75)
    let blue = Double.random(in: 0.1...0.75)
    
    return Color(red: red, green: green, blue: blue)
}


#Preview {
    SelectUnitsView()
}
