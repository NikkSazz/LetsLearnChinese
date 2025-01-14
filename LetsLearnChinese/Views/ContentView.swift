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
        
        let buttonHeight: CGFloat = 75
        
        NavigationStack{
            ZStack {
                
                DefaultBackground()
                
                VStack (alignment: .center, spacing: 10){ // dont think the spacing does anything
                    ScrollView {
                        
                        homeMenuButton(text: "NoteCard", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Writing", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Multiple Choice", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Fish Game", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Review Exam", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Emotional Duck", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Statistics", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "About Me", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        
                    } // scroll
                    .padding(.top, 130)
                    .padding(.bottom, 1)
                } // v
            } // z
        } // nav
    } // view body
} // view struct

#Preview {
    ContentView()
}
