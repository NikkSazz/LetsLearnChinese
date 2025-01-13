//
//  Title.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/11/25.
//
import SwiftUI

struct Title: View{
    var body: some View {
        VStack(spacing: -50) { // title
            
            Group {
                StrokedText(
                    text: "Let's Learn",
                    font: .custom("InknutAntiqua-Light", size: 26),
                    strokeColor: .black,
                    strokeWidth: 2,
                    fillColor: .accent
                )
                
                
                StrokedText(
                    text: "Chinese",
                    font: .custom("InknutAntiqua-Bold", size: 40),
                    strokeColor: .black,
                    strokeWidth: 2,
                    fillColor: .accent
                )
            }
            
            
        } // title v
        .padding(.horizontal, 72)
        .padding(.bottom, -16)
    }
}
