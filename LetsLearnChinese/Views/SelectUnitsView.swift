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
            ("Level 1", ["Unit 1.1", "Unit 1.2", "Unit 1.3", "Unit 1.4", "Unit 1.5"])
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
                    Text("Units may include characters and words from previous units, even if those units are not selected.")
                        .foregroundStyle(.accent)
                        .padding(.top)
                    
                    VStack(spacing: 20) {
                        ForEach(levels, id: \.0) { level in
                            VStack {
                                // Large rectangle for the level
                                
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.5)){
                                        // Check if all units in the level are already selected
                                        let allSelected = level.1.allSatisfy { selectedUnits.contains($0) }
                                        
                                        if allSelected {
                                            level.1.forEach { selectedUnits.remove($0) }
                                        } else {
                                            level.1.forEach { selectedUnits.insert($0) }
                                        }
                                    }
                                }){
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
                    // CHATGPT VERSION
                
                    Text(":)")
                        .foregroundStyle(.accent)
                    
                    ZStack{
                        Rectangle()
                            .frame(height: 200)
                            .foregroundStyle(.accent)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                    Text(":)")
                        .foregroundStyle(.accent)
                    
                    let size: CGFloat? = 100
                    let height: CGFloat? = 80
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            VStack (spacing: 0){
                                Text("Unit 1")
                                    .foregroundStyle(.accent)
                                Rectangle()
                                    .frame(width: size, height: height)
                                    .foregroundStyle(.accent)
                            } // v
                            .padding(.bottom, 10)
                            
                            VStack (spacing: 2){
                                Text("Unit 2")
                                    .foregroundStyle(.accent)
                                Rectangle()
                                    .frame(width: size, height: height)
                                    .foregroundStyle(.accent)
                            } // v
                            .padding(.bottom, 10)
                            
                            VStack (spacing: 2){
                                Text("Unit 3")
                                    .foregroundStyle(.accent)
                                Rectangle()
                                    .frame(width: size, height: height)
                                    .foregroundStyle(.accent)
                            } // v
                            .padding(.bottom, 10)
                            
                            VStack (spacing: 2){
                                Text("Unit 4")
                                    .foregroundStyle(.accent)
                                Rectangle()
                                    .frame(width: size, height: height)
                                    .foregroundStyle(.accent)
                            } // v
                            .padding(.bottom, 10)
                            
                            VStack (spacing: 2){
                                Text("Unit 5")
                                    .foregroundStyle(.accent)
                                Rectangle()
                                    .frame(width: size, height: height)
                                    .foregroundStyle(.accent)
                            } // v
                            .padding(.bottom, 10)
                            
                        } // h
                        .padding(.horizontal)

                    } // scroll horizontal
                    .background(.gray.opacity(0.25))
                    .frame(width: .infinity)
                    
                    Text(":)")
                        .foregroundStyle(.accent)
                } // scroll
                
                Button(action: {
                    
                }
                ){
                    Rectangle()
                        .frame(height: 50)
                        .padding(.bottom)
//                        .padding(.horizontal, 25)
                        .padding(.top, -5)
                        .foregroundStyle(.blue)
                }
            } // v
            .frame(maxHeight: .infinity, alignment: .top)
            
        } // z
    } // view body
} // view struct

#Preview {
    SelectUnitsView()
}
