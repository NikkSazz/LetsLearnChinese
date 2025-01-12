//
//  BottomBar.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/12/25.
//

import SwiftUI

struct BottomBar: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                // Inner shadow
                Rectangle()
                    .fill(Color.black.opacity(0.75))
                    .padding(2) // Padding for the inner shadow effect
                    .frame(height: 34)
                    .frame(maxWidth: .infinity)
                    .blur(radius: 5) // Adds the blur to the inner shadow
                
                // Outer box with shadow
                Rectangle()
                    .fill(Color.background)
                    .frame(height: 34)
                    .frame(maxWidth: .infinity)
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: -5) // Outer shadow
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
