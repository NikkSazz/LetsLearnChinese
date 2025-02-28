//
//  DictionarySingleCharacterView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/5/25.
//

import SwiftUI
import SQLite3

struct DictionarySingleCharacterView: View {
    
    let character: Character
    
    @State private var expandedChar: String? = nil
    @State private var expandedList: [Character] = []
    
    
    var body: some View {
        ZStack{
            DefaultBackground()
            
            
            
            VStack(spacing: 10) {
                        
                TopBar(title: character.pinyin, subtitle: character.chinese)
                    .frame(alignment: .top)
                
                Spacer()
                
                bigWord(character)
                
                NewMoreWordsWith(fullWord: character.chinese, expandedChar: $expandedChar, expandedList: $expandedList)
                
//                ExampleSentence()
                
                Spacer()
                
            } // v
            .frame(maxHeight: .infinity)
            .foregroundStyle(.accent)
        } // Z
    } // body some view
} // dictionary Signle Character View struct

struct bigWord: View {
    let character: Character
    
    init(_ character: Character) {
        self.character = character
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            coolDictText(character)
//                        .padding(.horizontal)
            
            VStack(spacing: 10) {
                Text(character.english)
                
                Text(character.pinyin)
                
                Text("Unit: \(character.unit_id ?? 0)\n\(unitEnglish(unit_id: character.unit_id ?? 0))")
            }
            .padding(.horizontal)
            .frame(width: 170, alignment: .leading)
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct coolDictText: View {
    let character: Character
    
    init(_ character: Character) {
        self.character = character
    } // makes things cleaner while coding
    
    var body: some View {
        Text(character.chinese)
            .font(.system(size: 65))
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.cyan.opacity(0.2), .purple.opacity(0.2)]),
                               startPoint: .bottomLeading,
                               endPoint: .topTrailing)
                .cornerRadius(10)
            ) // background
            .shadow(color: .black, radius: 3, x: -5, y: 5)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
//    MainMenu()
//    DictionarySingleCharacterView(character: Character(id: 9, chinese: "小姐", english: "miss", pinyin: "xiǎojiě"))
//    DictionarySingleCharacterView(character: Character(id: 235, chinese: "子大常老师", english: "Teacher Chang", pinyin: "Cháng lǎoshī", unit_id: 6))
    DictionarySingleCharacterView(character: Character(id: 327, chinese: "除了...以外", english: "except for", pinyin: "chúle... yǐwài", unit_id: 8))
}

// 「 你是谁？」《我是俄国人》 二零二五年 二月 十一日
