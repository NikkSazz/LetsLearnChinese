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
    var view: AnyView = AnyView(NotImplimentedView())
    var tutorialView: AnyView = AnyView(NotImplimentedView())
    
    let levels = [
            ("Units 1 - 5", ["Greetings", "Family", "Dates and Time", "Hobbies", "Visiting Friends"]),
            ("Units 6 - 10", ["Appointments", "Studying", "School Life", "Shopping", "Transportation"]),
        ]
        
    @State private var selectedUnits: Set<String> = []

    var body: some View {
        ZStack {
            
            DefaultBackground()
            
            VStack {
                
                TopBar(title: title, subtitle: "Select \(subtitle)")
                    .frame(alignment: .top)
                 
                ScrollView {
                    Text("May use characters, words, and sentences from previous unselected units.")
                        .lineLimit(2)
                        .foregroundStyle(.accent)
                        .padding(.horizontal, 20)
                   
               
                    Text(":)")
                        .padding(.top)
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
                                        }
                                    }
                                }) {
                                    VStack {
                                        Text("Select \(level.0)") // Level number at the top
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
                                                            Text("\(unit)") // Unit label
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
                                                                    Text(unitChinese(unitName: unit))
                                                                        .font(.system(size: 32))
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

                    
                    Text(":)")
                        .foregroundStyle(.accent)
                } // scroll
                
                NavigationLink(destination: view){
                    ZStack{
                        Rectangle()
                            .frame(height: 50)
                            .padding(.bottom)
                            .padding(.horizontal, 15)
                            .padding(.top, -5)
                            .foregroundStyle(.blue)
                        
                        Text("Continue to \(subtitle)")
                            .font(.custom("InknutAntiqua-Black", size: 24))
                            .foregroundStyle(.white)
                            .padding(.bottom, 25)
                    }
                    
                }
            } // v
            .frame(maxHeight: .infinity, alignment: .top)
            
        } // z
    } // view body
} // view struct

func unitChinese(unitName: String) -> String {
    switch unitName {
    case "Greetings":
        return "问好"
    case "Family":
        return "家庭"
    case "Dates and Time":
        return "时间"
    case "Hobbies":
        return "爱好"
    case "Visiting Friends":
        return "看朋友"
    case "Appointments":
        return "约时间"
    case "Studying":
        return "学中文"
    case "School Life":
        return "学校生活"
    case "Shopping":
        return "买东西"
    case "Transportation":
        return "交通"
    default:
        return "你好"
    }
}

#Preview {
    SelectUnitsView()
}
