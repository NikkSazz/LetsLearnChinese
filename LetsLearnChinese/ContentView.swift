//
//  ContentView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var motion = MotionManager()
    
    var body: some View {
        
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(alignment:  .center) { // Content
                
                VStack(spacing: -50) { // title
                    
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
                                

                } // title v
                .padding(.horizontal, 72)
                .padding(.bottom, 16)
                
                
    
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world! yo")
                    .foregroundStyle(.accent)
                    .backgroundStyle(.accent)
                
            } // v
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.bottom, 16)
            
        } // z
    } // view
} // view struct

#Preview {
    ContentView()
}
