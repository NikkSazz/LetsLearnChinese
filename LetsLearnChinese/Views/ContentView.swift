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
                        NavigationLink(destination: TestView()){
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
                                
                                
                                Text("Go to Second View")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .font(.custom("InknutAntiqua-Bold", size: UIScreen.main.bounds.width * 0.08 - 5))
                                    .lineLimit(1)
                            }
                        }
                        .padding()
                        .padding(.bottom, -30)
                        
                        NavigationLink(destination: TestView()){
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
                                
                                
                                Text("Test Test TEst")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .font(.custom("InknutAntiqua-Bold", size: UIScreen.main.bounds.width * 0.08 - 5))
                                    .lineLimit(1)
                            }
                        }
                        .padding()
                        
                        NavigationLink("Go to Second View", destination: TestView())
                    } // scroll
                    .padding(.top, 130)
                } // v
            } // z
        } // nav
    } // view body
} // view struct

#Preview {
    ContentView()
}
