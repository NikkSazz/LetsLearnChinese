//
//  ContentView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack(alignment:  .center) {
                
                VStack(spacing: -40) {
                    //Title
                    Text("Let's Learn")
                        .font(.custom("InknutAntiqua-Light", size: 26))

                        
                    Text("Chinese")
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
