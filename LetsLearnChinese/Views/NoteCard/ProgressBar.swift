//
//  ProgressBar.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/16/25.
//

import SwiftUI

import SwiftUI

class ProgressViewModel: ObservableObject {
    @Published public var progress: Double {
        didSet {
            // Restrict the value between 0.0 and 1.0
            if progress < 0.0 {
                progress = 0.0
            } else if progress > 1.0 {
                progress = 1.0
            }
        }
    }
    
    @Published var progressList: [Character] = []
    
    init() {
        self.progress = 0.0
    }
}

struct AccentToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.body)
                .foregroundColor(.accent)

//            Spacer() // uncomment this, if you want the doesnt repeat and the rounded rectangle to be spaced

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
