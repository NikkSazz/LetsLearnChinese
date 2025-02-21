//
//  AllCharView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/31/25.
//

import SwiftUI


struct AllCharView: View {
    
    @State private var inputText: String = ""
    
    var body: some View {
        let characters: [Character] = loadAllCharacters()
        
        ZStack{
            DefaultBackground()
            VStack {
                TopBar(title: "Character List", subtitle: "汉字表")
                
                
                CustomTextField(inputText: $inputText)
                
                HStack {
                    Text("Chinese")
                    Spacer()
                    Text("English")
                    Spacer()
                    Text("Pinyin")
                }
                .padding(.horizontal, 30)
                .font(.custom("InknutAntiqua-Bold", size: 22))
                .shadow(radius: 2)
                .foregroundStyle(Color.accentColor)
                .frame(height: 30)
                
                DividerStyle().opacity(0.2)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        
                        ForEach(characters, id: \ .id) { character in
                            CharacterTriple(character: character)
                        } // for each
                    } //v
                    Spacer(minLength: 25)
                } // scroll
                .padding(.bottom, 1)
            } // v
        } //Z Stack
    }//body
} // allcharview struct

struct CharacterTriple: View {
    var character: Character
    var body: some View {
        VStack{
            HStack {
                Text("\(character.chinese)")
                    .font(.system(size: 22))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(character.english)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(character.pinyin)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 50)
            .padding(.top, 5) // makes more symmetry
            .font(.subheadline)
            .foregroundStyle(Color.accentColor)
            
            DividerStyle().opacity(0.2)
        }//v
    }
}

#Preview {
    AllCharView()
}
