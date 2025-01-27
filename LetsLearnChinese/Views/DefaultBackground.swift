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
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
    }
}

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

struct BottomBar: View {
    var body: some View {
        VStack {
//            Spacer()
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
