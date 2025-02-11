//
//  DictionarySingleCharacterView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/5/25.
//

import SwiftUI

struct DictionarySingleCharacterView: View {
    
    let character: Character
    @State private var oldExpandedEachChar = false
    @State private var expandedEachChar = false
    
    
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
                        .cornerRadius(10)
                    ) // background
                    .shadow(color: .black, radius: 3, x: -5, y: 5)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                
                // Old
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
                // \Old
                
                //New
                // \new

                
            } // v
            .foregroundStyle(.accent)
        } // Z
    } // body some view
} // dictionary Signle Character View struct

#Preview {
//    DictionarySingleCharacterView(character: Character(id: 9, chinese: "小姐", english: "miss", pinyin: "xiaojie"))
    DictionarySingleCharacterView(character: Character(id: 196, chinese: "图书馆", english: "library", pinyin: "túshūguǎn"))
}

// 「 你是谁？」《我是俄国人》 二零二五年 二月 十一日 
