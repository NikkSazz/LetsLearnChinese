//
//  NoteCardView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/29/25.
//

import SwiftUI

// Duck Data Model
struct Duck: Identifiable {
    var id = UUID()
    var name: String
    var image: String
}

// The Duck Selector View
struct NoteCardView: View {
    // Available ducks
    let ducks = [
        Duck(name: "Duck 1", image: "duck.png"),
        Duck(name: "Duck 2", image: "duck.png"),
        Duck(name: "Duck 3", image: "duck.png")
    ]
    
    @State private var selectedDuck: Duck? = nil
    
    var body: some View {
        VStack {
            Text("Select Your Duck")
                .font(.title)
                .padding()
            
            // Grid of ducks
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                ForEach(ducks) { duck in
                    Image(duck.image)  // Your duck image here
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedDuck?.id == duck.id ? Color.blue : Color.clear, lineWidth: 4)
                        )
                        .onTapGesture {
                            selectedDuck = duck
                        }
                }
            }
            .padding()
            
            // Show selected duck details
            if let selectedDuck = selectedDuck {
                Text("You selected: \(selectedDuck.name)")
                    .padding()
                
                // Confirm button
                Button("Confirm Selection") {
                    // Action when duck is confirmed
                    print("Selected Duck: \(selectedDuck.name)")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    NoteCardView()
}
