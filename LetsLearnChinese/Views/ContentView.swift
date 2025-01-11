//
//  ContentView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/8/25.
//

import SwiftUI

struct ContentView: View {
//    @StateObject private var motion = MotionManager()
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                
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
                            .shadow(color: Color.black.opacity(0.25), radius: 5, x: 0, y: -5) // Outer shadow
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                
                NavigationLink("Go to Second View", destination: TestView())
            }
        } // nav
    } // view body
} // view struct

#Preview {
    ContentView()
}
