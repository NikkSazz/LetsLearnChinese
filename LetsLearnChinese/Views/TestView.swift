//
//  ContentView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/8/25.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack(alignment:  .center) { // Content
                    
                    //                Title()
                    VStack(spacing: -50) {
                        
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
                        
                        
                    }
                    .padding(.horizontal, 72)
                    .padding(.bottom, -16)
                    //                Title()
                    
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(0..<8) { index in
                                NavigationLink(destination: {
                                    ContentView()
                                }, label: {
                                    Button(action: {
                                        print("Button \(index) tapped")
                                    }) {
                                        Rectangle()
                                            .fill(Color.red)
                                            .frame(height: 75)
                                            .cornerRadius(8)
                                    }
                                    Spacer()
                                })
                            }
                        }
                        .padding()
                    }
                    
                } // v
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.bottom, 16)
            }
            
        } // z
//        .navigationBarBackButtonHidden(true) // keep this 
        .interactiveDismissDisabled(false)
    } // view
} // view struct

//#Preview {
//    TestView()
//}