//
//  AllCharView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/31/25.
//

import SwiftUI


struct AllCharView: View {
    
    @State private var inputText: String = ""
    @State private var searchResults: [Character]? = nil
    
    var body: some View {
        let characters: [Character] = loadAllCharacters()
        
        ZStack{
            DefaultBackground()
            VStack {
                TopBar(title: "Character List", subtitle: "汉字表")
                
                
                CustomTextField(inputText: $inputText)
                    .onChange(of: inputText) {
                                print("Changing searchResults")
                                searchResults = textFeildCharacterSQL(of: inputText)
                                
                                print("searchResults:")
                                print(searchResults ?? "nil")
                            }
                
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
                    LazyVStack(alignment: .leading, spacing: 5) { // load only the visible elements
                        
                        ForEach(searchResults == nil ? characters : searchResults!, id: \ .id) { character in
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

#Preview {
    AllCharView()
}
