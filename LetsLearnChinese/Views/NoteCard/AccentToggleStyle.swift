//
//  AccentToggleStyle.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/26/25.
//

import SwiftUI

struct AccentToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.body)
                .foregroundColor(.accent)

            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color.accentColor : Color.gray.opacity(0.4)) // Track color
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ?
                              Color.white :
                                Color.white.opacity(0.75)) // Thumb color
                        .shadow(radius: 1)
                        .padding(2)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut(duration: 0.4), value: configuration.isOn)
                ) // circle overlay
                .onTapGesture {
                    configuration.isOn.toggle()
                } // ontap of overlay
        } // H label, and toggle
        .padding(.horizontal)
    } // view
} // Custom Toggle Style Struct
