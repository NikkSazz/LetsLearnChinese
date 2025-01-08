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
                
                VStack(spacing: -4) {
                    //Title
                    Text("Let's Learn")
                        .fontWeight(.light)
                        .font(.system(size: 26))
                        
                    Text("Chinese")
                        .bold()
                        .font(.system(size: 40))
                    
                } // title v
                .padding(.horizontal, 72)
//                .padding(.top, 70)
                .padding(.bottom, 16)
                .foregroundStyle(.accent)
                
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
