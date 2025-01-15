//
//  DefaultBackground.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/12/25.
//
import SwiftUI

struct DefaultBackground: View {
    var body: some View {
        Color.black
            .ignoresSafeArea()
        //Outer Edge Black
        
        Color.black
            .opacity(0.25)
            .overlay(
                Rectangle()
                    .fill(.scrollBackground)
                    .padding(10) // Padding for the inner shadow effect
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .blur(radius: 25) // Change this if you want less shadow ikr
            )
            .shadow(color: Color.black.opacity(0.25), radius: 5, x: 5, y: -5)
            .ignoresSafeArea()
        // Gray inside
        
//        TopBar(title: "A", subtitle: "AA")        
        
        BottomBar()
    }
}
