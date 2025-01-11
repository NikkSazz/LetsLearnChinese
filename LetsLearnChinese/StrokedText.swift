//
//  StrokedText.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/10/25.
//
import SwiftUI

struct StrokedText: View {
    var text: String
    var font: Font
    var strokeColor: Color
    var strokeWidth: CGFloat
    var fillColor: Color

    var body: some View {
        ZStack {
            // Stroke text (outer)
            Text(text)
                .font(font)
                .foregroundColor(strokeColor)
                .offset(x: strokeWidth, y: strokeWidth) // Offset for outer stroke
            
            // Fill text (main)
            Text(text)
                .font(font)
                .foregroundColor(fillColor)
        }
    }
}

struct InnerShadowText: View {
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
 InnerShadowText(
     text: "Chinese",
     font: .custom("InknutAntiqua-Bold", size: 40),
     strokeColor: .black,
     strokeWidth: 10,
     fillColor: .accent,
     innerShadowColor: .black.opacity(0.1),
     shadowRadius: 1,
     shadowOffset: (x: -8, y: -15)
 )
 */
