//
//  DataBaseTestView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/21/25.
//

import SwiftUI

struct DataBaseTestView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack{
            DefaultBackground()
                .onAppear {
                    if !UserDefaults.standard.bool(forKey: "isDatabasePopulated") {
                        populateDatabase()
                        UserDefaults.standard.set(true, forKey: "isDatabasePopulated")
                    }
                }
            
            VStack (spacing: 20) {
                Text("Hello World!")
                    .foregroundStyle(.accent)
                Text("Hello World!!")
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }
}
