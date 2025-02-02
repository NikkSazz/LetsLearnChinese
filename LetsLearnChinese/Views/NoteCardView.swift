//
//  NoteCardView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/29/25.
//

import SwiftUI

struct NoteCardView: View {
    @State private var isFlipped = false
    var body: some View {
        let animationDuration = 0.5
        ZStack{
            DefaultBackground()
            
            TopBar(title: "NoteCards", subtitle: "学习")
                .frame(maxHeight: .infinity, alignment: .top)
            
            ZStack {
                let c: Character
                
                if isFlipped {
                    // Back side of the card
                    CardBack()
                } else {
                    // Front side of the card
                    CardFront()
                }
            } // z
            .frame(width: .infinity, height: 300) // Adjust size as needed
            .cornerRadius(16)
            .shadow(radius: 5)
            .rotation3DEffect(
                .degrees(isFlipped ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .onTapGesture {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    isFlipped.toggle()
                }
            } // ontapgesture
            .padding(.horizontal, 75)
            
        }//z
        
    } // body
} // notecardview

struct CardFront: View {
    var body: some View {
        Text("图书馆")
            .font(.system(size: 50))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor.gradient)
            .cornerRadius(16)
    }
}

struct CardBack: View {
    var body: some View {
        
        VStack {
            Text("Library")
                .padding(.bottom)
                .font(.system(size: 65))
            Text("túshūguǎn")
                .font(.system(size: 30))
        }
        .scaleEffect(x: -1, y: 1) // flipped
        .foregroundColor(.accent)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.gradient.opacity(0.5))
        .cornerRadius(16)
    }
}

#Preview {
    NoteCardView()
}
