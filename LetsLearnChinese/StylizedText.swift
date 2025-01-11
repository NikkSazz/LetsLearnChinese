//
//  StylizedText.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/10/25.
//
import SwiftUI

// # This does not work at all 0w0

struct StylizedText: View {
    var text: String
    var font: Font
    var strokeColor: Color
    var strokeWidth: CGFloat
    var fillColor: Color
    var innerShadowColor: Color
    var shadowRadius: CGFloat
    var shadowOffset: (x: CGFloat, y: CGFloat)
    
    var body: some View {
        ZStack {
            // Base text fill
            Text(text)
                .font(font)
                .foregroundColor(fillColor)
            
            // Stroked text using an overlay
            Text(text)
                .font(font)
                .foregroundColor(.clear)
                .overlay(
                    Text(text)
                        .font(font)
                        .foregroundColor(strokeColor)
                        .blur(radius: strokeWidth)
                        .mask(
                            Text(text)
                                .font(font)
                                .foregroundColor(.black)
                        )
                )
            
            // Inner shadow
            Text(text)
                .font(font)
                .foregroundColor(innerShadowColor)
                .blur(radius: shadowRadius)
                .offset(x: shadowOffset.x, y: shadowOffset.y)
                .mask(
                    Text(text)
                        .font(font)
                        .foregroundColor(.black)
                )
        }
    }
}

/*
 StylizedText(
     text: "Chinese",
     font: .custom("InknutAntiqua-Bold", size: 40),
     strokeColor: .black,
     strokeWidth: 1,
     fillColor: .accent,
     innerShadowColor: .black.opacity(10),
     shadowRadius: 1,
     shadowOffset: (x: -8, y: -8)
 )
 
 StylizedText(
     text: "Let's Learn",
     font: .custom("InknutAntiqua-Light", size: 26),
     strokeColor: .black,
     strokeWidth: 2,
     fillColor: .accent,
     innerShadowColor: .black.opacity(0.5),
     shadowRadius: 4,
     shadowOffset: (x: 2, y: 2)
 )
 */
