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
            VStack(alignment:  .center) {
                
                VStack(spacing: -40) {
                    //Title
                    Text("Let's Learn")
                        .foregroundStyle(
                            .accent.gradient.shadow(
                                .inner(color: .black, radius: 1, x: motion.x * 50, y: motion.y * 50)
                            )
                            .shadow(
                                .drop(color: .black.opacity(0.2), radius: 1, x: motion.x * 50, y: motion.y * 50)
                            )
                        )
                        .font(.custom("InknutAntiqua-Light", size: 26))
//                        .overlay(
//                                Text("Let's Learn")
//                                    .font(.custom("InknutAntiqua-Light", size: 26))
//                                    .stroke(Color.blue, lineWidth: 10) // Stroke color and width
//                            )

                        
                    Text("Chinese")
                        .foregroundStyle(
                            .accent.gradient.shadow(
                                .inner(color: .black, radius: 1, x: motion.x * 50, y: motion.y * 50)
                            )
                            .shadow(
                                .drop(color: .black.opacity(0.2), radius: 3, x: motion.x * 50, y: motion.y * 50)
                            )
                        )
                        .font(.custom("InknutAntiqua-Bold", size: 40))
                    
                } // title v
                .padding(.horizontal, 72)
                .padding(.bottom, 16)
                .foregroundStyle(.accent) // Color
                
                
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
