//
//  AllCharView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/31/25.
//

import SwiftUI

struct AllCharView: View {
    var body: some View {
        Text("Hello World")
    } // body
} // allcharview struct

struct Character: Identifiable {
    let id: Int
    let chinese: String
    let english: String
    let pinyin: String
    let unitId: Int
    let type: String
}

#Preview {
    AllCharView()
}
