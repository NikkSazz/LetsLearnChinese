//
//  TopBar.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/12/25.
//

import SwiftUI

struct TopBar: View {
    var title: String = "Let's Learn"
    var subtitle: String = "Chinese"
    
    var body: some View {
        Group {
            VStack(spacing: -50) { // Title and subtitle stack
                Group {
                    StrokedText(
                        text: title,
                        font: .custom("InknutAntiqua-Light", size: 26),
                        strokeColor: .black,
                        strokeWidth: 2,
                        fillColor: .accent
                    )
                    
                    StrokedText(
                        text: subtitle,
                        font: .custom("InknutAntiqua-Bold", size: 40),
                        strokeColor: .black,
                        strokeWidth: 2,
                        fillColor: .accent
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color.background)
            .shadow(color: .black.opacity(0.55), radius: 5, x: 4, y: 5)
        }
        .frame(height: 113, alignment: .top)
    }
}

#Preview {
    TopBar()
}
