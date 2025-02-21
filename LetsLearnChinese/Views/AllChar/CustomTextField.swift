//
//  CustomTextFeild.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/21/25.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var inputText: String
//    private let characterLimit = 20
    
    var body: some View {
        HStack {
            TextField("Search Chinese, English, or Pinyin ...", text: $inputText)
                .padding()
//                .padding(.horizontal)
                .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
            
            // Clear button
            Button(action: {
                inputText = "" // Clear the text
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.buttonEdge.opacity(0.75))
//                    .padding()
            }
            .frame(width: 20)
            .padding(.trailing, 16)
        } // z
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.accentColor.opacity(0.8), lineWidth: 3))
        .padding()
        
        Text(inputText)
            .lineLimit(1)
            .font(.body)
            .foregroundColor(.accent)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.black)
            .cornerRadius(10)
            .padding(.horizontal)


    }
}
