//
//  TopBar.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/12/25.
//

import SwiftUI

struct TopBar: View {
    var body: some View {
        VStack {
            Title()
                .padding(.top, 70)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.background)
                .shadow(color: .black.opacity(0.55), radius: 5, x: 4, y: 5)

            Spacer()  // dont delete
        }
        .edgesIgnoringSafeArea(.top)
    }
}
