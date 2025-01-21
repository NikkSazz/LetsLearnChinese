//
//  DataBaseTestView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/21/25.
//

import SwiftUI

struct DataBaseTestView: View {
    var body: some View {
        ZStack{
            DefaultBackground()
            
            VStack (spacing: 20) {
                Text("Hello World!")
                    .foregroundStyle(.accent)
                Text("Hello World!!")
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }
}

#Preview {
    DataBaseTestView()
}
