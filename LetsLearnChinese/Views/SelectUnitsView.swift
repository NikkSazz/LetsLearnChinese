//
//  SelectUnitsView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/24/25.
//

import SwiftUI

struct SelectUnitsView: View {
    var title: String = "Let's Learn Chinese"
    var subtitle: String = "Units"
    
    var view: (Binding<Set<Int>>) -> AnyView = { _ in
        AnyView(Text("Not Implemented View")) }
    
    var continueTo: String = "Next"
    
    let levels = [
            ("Units 1 - 5", [1,2,3,4,5]),
            ("Units 6 - 10", [6,7,8,9,10]),
            ("Units 11 - 15", [11,12,13,14,15]),
            ("Units 16 - 20", [16,17,18,19,20])
        ]
        
    @State private var selectedUnits: Set<Int> = []

    var body: some View {
        ZStack {
            
            DefaultBackground()
            
            VStack {
                
                TopBar(title: title, subtitle: "Select \(subtitle)")
                    .frame(alignment: .top)
                 
                ScrollView {
                    Text("Scroll\t->\tPress your desired Units"
                         + "\nPressing *Select* for all 5 units")
                        .lineLimit(2)
                        .foregroundStyle(.accent)
                        .padding(.horizontal, 20)
                        .padding(.top)
                    
                    
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
                                        }
                                    }
                                }) {
                                    VStack {
                                        Text("Select \(level.0)") // Level number at the top "Units 1 - 5"
                                            .font(.custom("InknutAntiqua-Black", size: 24))
                                            .foregroundStyle(level.1.allSatisfy { selectedUnits.contains($0) } ? .black : .black.opacity(0.75))
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(level.1.allSatisfy { selectedUnits.contains($0) } ? .accent : .white.opacity(0.1))
                                                    .frame(height: 40)
                                            )
                                            .frame(height: 40)
                                        
                                        // Horizontal ScrollView of unit buttons inside the rectangle
                                        ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(spacing: 10) {
                                                    ForEach(level.1, id: \.self) { unit in
//                                                        unitColors[unit] = RandomColor()
                                                        VStack(spacing: 2) {
                                                            Text("\(unitEnglish(unit_id: unit))") // Unit label
                                                                .foregroundStyle(selectedUnits.contains(unit) ? .accent.opacity(0.75) : .black.opacity(0.75))
                                                            Button(action: {
                                                                if selectedUnits.contains(unit) {
                                                                    selectedUnits.remove(unit) // Deselect if already selected
                                                                } else {
                                                                    selectedUnits.insert(unit) // Select the unit
                                                                }
                                                            }) {
                                                                ZStack{
                                                                    Rectangle()
                                                                        .frame(width: 100, height: 80)
                                                                        .foregroundStyle(selectedUnits.contains(unit) ? .accent : .accent.opacity(0.25))
                                                                        .cornerRadius(5)
                                                                    Text(unitChinese(unitName: unitEnglish(unit_id: unit)))
                                                                        .font(.system(size: 26))
                                                                        .foregroundStyle(selectedUnits.contains(unit) ? .black : .black.opacity(0.75))
                                                                }// z
                                                            } // button
                                                            .buttonStyle(PlainButtonStyle())
                                                        } // v
                                                        .padding(.bottom, 10)
                                                        Spacer(minLength: 5)
                                                    } // for each
                                                } // hstack
                                                .padding(.horizontal)
                                            } // scroll
                                            .background(Color.gray.opacity(0.25))
                                            .frame(maxWidth: .infinity)
                                        } // v
                                } // button
                                .buttonStyle(PlainButtonStyle())
                            } // v
                        } // foreach level
                    }// v
                    .padding()

                } // scroll
                
                NavigationLink(destination: view($selectedUnits)){
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50)
                            .padding(.bottom)
                            .padding(.horizontal, 15)
                            .padding(.top, -5)
                            .foregroundStyle(.blue)
                        
                        Text("Continue to \(continueTo)")
                            .font(.custom("InknutAntiqua-Black", size: 24))
                            .foregroundStyle(.white)
                            .padding(.bottom, 25)
                    } // Z
                    .frame(height: 60)
                    
                } // navlink
                .opacity(selectedUnits.isEmpty ? 0.5 : 1.0)
                .disabled(selectedUnits.isEmpty)
            } // v
            .frame(maxHeight: .infinity, alignment: .top)
            
        } // z
    } // view body
} // view struct

#Preview {
    SelectUnitsView()
}
