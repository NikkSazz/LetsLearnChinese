//
//  DictionarySingleCharacterView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/5/25.
//

import SwiftUI

struct DictionarySingleCharacterView: View {
    
    let character: Character
    
    
    var body: some View {
        ZStack{
            DefaultBackground()
            
            VStack(spacing: 10) {
                    
                    Text(character.chinese)
                        .font(.system(size: 65))
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.cyan.opacity(0.2), .purple.opacity(0.2)]),
                                           startPoint: .bottomLeading,
                                           endPoint: .topTrailing)
                            .cornerRadius(10) // Rounded edges for the background
                        ) // background
                        .shadow(color: .black, radius: 3, x: -5, y: 5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                        .padding(.vertical)
            } // v
            .foregroundStyle(.accent)
        } // Z
    } // body some view
} // dictionary Signle Character View struct

#Preview {
    DictionarySingleCharacterView(character: Character(id: 9, chinese: "小姐", english: "miss", pinyin: "xiaojie"))
}

// 「 你是谁？」《我是俄国人》 二零二五年 二月 十一日 
