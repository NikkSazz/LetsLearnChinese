//
//  ExampleSentence.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/28/25.
//

import SwiftUI

struct ExampleSentence: View {
    var body: some View {
        Rectangle()
            .frame(height: 200)
    }
}

#Preview {
    DictionarySingleCharacterView(character: Character(id: 9, chinese: "子是小姐", english: "miss", pinyin: "xiǎojiě"))
//    DictionarySingleCharacterView(character: Character(id: 235, chinese: "常老师", english: "Teacher Chang", pinyin: "Cháng lǎoshī", unit_id: 6))
}
