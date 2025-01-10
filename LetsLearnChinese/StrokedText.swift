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
