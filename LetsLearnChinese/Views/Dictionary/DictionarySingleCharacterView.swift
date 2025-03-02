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
                
                bigWord(character: character, expanded: expandedChar, expandedListLen: expandedList.count)
                
                MoreWordsWith(fullWord: character.chinese, expandedChar: $expandedChar, expandedList: $expandedList)
                
                ExampleSentence()
                
                Spacer()
                
            } // v
            .frame(maxHeight: .infinity)
            .foregroundStyle(.accent)
        } // Z
    } // body some view
} // dictionary Signle Character View struct

struct bigWord: View {
    let character: Character
    let expanded: String?
    let expandedListLen: Int
    
    var body: some View {
        HStack {
            Spacer()
            
            coolDictText(anythingExpanded: expanded, character: character, expandedList: expandedListLen)
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
    let anythingExpanded: String?
    let expandedList: Int
    let character: Character
    
    var body: some View {
        Text(anythingExpanded != nil ? character.chinese.prefix(1) + "..." : character.chinese)
            .font(.system(size: anythingExpanded != nil ? 50 : 65)) // Reduce font size if folded
            .lineLimit(
                anythingExpanded == nil ? 2 : // I have no idea what this does, cuz it doesnt even work :/ ?
                    expandedList > 3 ? 1 : 2)
            .padding()
            .frame(width: 150, alignment: .center) // Set fixed width for consistency
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.cyan.opacity(0.2), .purple.opacity(0.2)]),
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
                .cornerRadius(10)
            )
            .shadow(color: .black, radius: 3, x: -5, y: 5)
            .minimumScaleFactor(0.5) // Allows scaling down text size if necessary
    }
}

#Preview {
//    MainMenu()
    
    // Defualt
//    DictionarySingleCharacterView(character: Character(id: 9, chinese: "小姐", english: "miss", pinyin: "xiǎojiě"))
    
    // Many MoreWordsWith
//    DictionarySingleCharacterView(character: Character(id: 235, chinese: "子大常老师", english: "Teacher Chang", pinyin: "Cháng lǎoshī", unit_id: 6))
    
    // Long Chinese
    DictionarySingleCharacterView(character: Character(id: 327, chinese: "除了...以外", english: "except for", pinyin: "chúle... yǐwài", unit_id: 8))
    
    // Long English
//    DictionarySingleCharacterView(character: Character(id: 261, chinese: "张", english: "measure word (for flat objects)", pinyin: "zhāng", unit_id: 7))
}

// 「 你是谁？」《我是俄国人》 二零二五年 二月 十一日
