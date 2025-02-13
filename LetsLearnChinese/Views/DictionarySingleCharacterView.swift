//
//  DictionarySingleCharacterView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/5/25.
//

import SwiftUI

struct DictionarySingleCharacterView: View {
    
    let character: Character
    
    @State private var expandedChar: String? = nil
    @State private var expandedList: [Character] = []
    
    
    var body: some View {
        ZStack{
            DefaultBackground()
            
            VStack(spacing: 10) {
                    
                
                coolDictText(character)
                
                //New
                ForEach(character.chinese.map { String($0) }, id: \.self) { char in
                    Button {
                        withAnimation {
                            expandedChar = expandedChar == char ? nil : char
                            updateExpandedList(with: expandedChar)
                            print("Button with \(char) pressed")
                        } // withAnimation
                    } label: {
                        
                        HStack {
                            Text("More Words with")
                            
                            Text(char)
                                .font(.system(size: 30))
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 2)
                        .background(/*expandedEachChar &&*/
                                    expandedChar == char ?
                                    Color.black.opacity(0.4) : Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        
                        Spacer() // move text to leading
                        
                    } // button label

                    if expandedChar == char {
                        VStack{
                            ForEach(expandedList, id: \.id) { character in
                                Text(character.chinese)
                            } // For each in expandedList
                        } // V
                        .transition(.opacity.combined(with: .move(edge: .trailing)))
                    } // if expandedChar == char
                    
                } // for each char in Dictionary Character
                
                
                // \new
                
                Text("Expanded \(expandedChar ?? "∅")")
                    .font(.system(size: 30))
                
            } // v
            .foregroundStyle(.accent)
        } // Z
    } // body some view
    
    func updateExpandedList(with char: String?) {
        expandedList.removeAll()
        expandedList.append(Character(id: 9, chinese: "小姐", english: "miss", pinyin: "xiaojie"))
        expandedList.append(Character(id: 196, chinese: "图书馆", english: "library", pinyin: "túshūguǎn"))
    } // func updateExpandedList
    
} // dictionary Signle Character View struct

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
//    DictionarySingleCharacterView(character: Character(id: 9, chinese: "小姐", english: "miss", pinyin: "xiaojie"))
    DictionarySingleCharacterView(character: Character(id: 196, chinese: "图书馆", english: "library", pinyin: "túshūguǎn"))
}

// 「 你是谁？」《我是俄国人》 二零二五年 二月 十一日
