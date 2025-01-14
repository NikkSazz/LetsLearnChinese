//
//  HomeMenuButton.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/14/25.
//

import SwiftUI

func homeMenuButton<Destination: View>(
    text: String,
    destination: Destination,
    buttonHeight: CGFloat
) -> some View {
    NavigationLink(destination: destination){
        ZStack {
            Rectangle()
                .fill(Color.buttonEdge)
                .frame(height: buttonHeight)
                .cornerRadius(10)
            
            Rectangle()
                .fill(Color.buttonFill)
                .frame(height: buttonHeight - 10)
                .cornerRadius(10)
                .padding(.all, 4)
            
            
            Text(text)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .font(.custom("InknutAntiqua-Bold", size: UIScreen.main.bounds.width * 0.08 - 5))
                .lineLimit(1)
        } // z
    } // navlink
    .padding()
    .padding(.bottom, -25)
    } // view
