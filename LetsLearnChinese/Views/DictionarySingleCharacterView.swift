//
//  DictionarySingleCharacterView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/5/25.
//

import SwiftUI

struct DictionarySingleCharacterView: View {
    
    let character: Character
    
    @State private var oldExpandedEachChar = false // delete when removing the old version
//    @State private var expandedEachChar = false // redundant due to expandedChar
    @State private var expandedChar = "я"
    @State private var expandedCharList: [Character]
    
    
    var body: some View {
        ZStack{
            DefaultBackground()
            
            VStack(spacing: 10) {
                    
                
                coolDictText(character)
                
                oldThing(character: character)
                
                //New
                ForEach(character.chinese.map { String($0) }, id: \.self) { char in
                    Button {
                        withAnimation {
                            //                        expandedEachChar.toggle()
                            expandedChar = expandedChar == char ? "я" : char
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
                        let arr = findExactAndRelatedCharacters(character: char)
                        VStack{
                            ForEach(arr, id: \.self) { element in
                                CharacterTriple(character: element)
                            }
                        } // V
                        .transition(.opacity.combined(with: .move(edge: .trailing)))
                    } // if expandedChar == char
                    
                } // for each char in Dictionary Character
                
                Text("\(expandedChar)")
                    .font(.system(size: 50))
                // \new
                
            } // v
            .foregroundStyle(.accent)
        } // Z
    } // body some view
    
    func findExactAndRelatedCharacters(character: String) -> [Character] {
        var arr: [Character] = []
        var c: Character
        c = Character(id: 1, chinese: "你好", english: "Hello", pinyin: "NiHao")
        arr.append(c)
        c = Character(id: 2, chinese: "爱好", english: "Hobbies", pinyin: "AiHao")
        arr.append(c)
        c = Character(id: 3, chinese: "图书馆", english: "Library", pinyin: "TuShuGuan")
        arr.append(c)
        return arr
    }
    
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

struct oldThing: View {
    @State var oldExpandedEachChar = false
    let character: Character
    
    var body: some View {
        //old
        Button {
            withAnimation {
                oldExpandedEachChar.toggle()
            }
        } label: {
            HStack() {
                Text("\(character.id)")
                Text("\(character.english)")
                    .padding(.leading)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(character.chinese)")
                    Text("\(character.pinyin)")
                }
                .multilineTextAlignment(.trailing)
                
            } // h
            .foregroundStyle(.accent)
            .frame(height: 50)
            .padding(.horizontal, 30) // inner padding
            .padding(.vertical, 2)
            .background(oldExpandedEachChar ?
                        Color.black.opacity(0.4) : Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal, 30) // outer padding
        } // expandedEachChar Button
        
        if oldExpandedEachChar {
            VStack {
                ForEach(character.chinese.map { String($0) }, id: \.self) { char in
//                            let charAsString = String(char)
                    Text(char)
                }
            } // v
        } // if expandedEachChar
        // \old
    }
}

#Preview {
    DictionarySingleCharacterView(character: Character(id: 9, chinese: "小姐", english: "miss", pinyin: "xiaojie"))
//    DictionarySingleCharacterView(character: Character(id: 196, chinese: "图书馆", english: "library", pinyin: "túshūguǎn"))
}

// 「 你是谁？」《我是俄国人》 二零二五年 二月 十一日 
