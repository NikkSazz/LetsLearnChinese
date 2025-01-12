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
            ZStack {
                
                DefaultBackground()
                
                NavigationLink("Go to Second View", destination: TestView())
            } // z
        } // nav
    } // view body
} // view struct

#Preview {
    ContentView()
}
