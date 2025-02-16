//
//  CardFrontBack.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/16/25.
//

import SwiftUI

struct NoteCard: View {
    var character: Character
    var animationDuration: TimeInterval
    @State private var isFlipped = false
    var body: some View {
        ZStack {
            
            if isFlipped {
                CardBack(c: character)
            } else {
                CardFront(c: character)
            }
        } // z
        .frame(height: 300)
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
        .gesture( // on swipe
            DragGesture()
                .onChanged { value in
                    // Detect if the swipe is left to right
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        isFlipped.toggle()
                    }
                }
        ) // swipe gesture
        .padding(.horizontal, 75)
        .padding(.vertical, 30)
    } // body view
} // NoteCard View

struct CardFront: View {
    var c: Character
    
    var body: some View {
        Text(c.chinese)
            .font(.system(size: 50))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor.gradient)
            .cornerRadius(16)
    } // view
} // CardFront View

struct CardBack: View {
    var c: Character = Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn")
    
    var body: some View {
        
        VStack {
            Text(c.english)
                .padding(.bottom)
                .font(.system(size: 50))
            Text(c.pinyin)
                .font(.system(size: 30))
        }
        .scaleEffect(x: -1, y: 1) // flipped
        .foregroundColor(.accent)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.gradient.opacity(0.5))
        .cornerRadius(16)
    } // body view
} // CardBack View

