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
                Text("Dictionary Signle Character View")
                
                Text("Character: \(character.chinese)")
                
                Text("Pinyin: \(character.pinyin)")
            
                Text("English: \(character.english)")
            }
            .foregroundStyle(.accent)
        } // Z
    } // body some view
} // dictionary Signle Character View struct

#Preview {
    DictionarySingleCharacterView(character: Character(id: 9, chinese: "小姐", english: "miss", pinyin: "xiaojie"))
}
