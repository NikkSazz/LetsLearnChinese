//
//  AllCharView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/31/25.
//

import SwiftUI
//import Combine


struct AllCharView: View {
    
    /// Every Possible Character, Used if searchResults is nil
    let characters: [Character] = loadAllCharacters()
    
    /// Search Bar
    @State private var inputText: String = ""
    
    /// Selects only words which contain the inputText
    @State private var searchResults: [Character]? = nil
    
//    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        ZStack{
            DefaultBackground()
            VStack {
                TopBar(title: "Character List", subtitle: "汉字表")
                
                
                CustomTextField(inputText: $inputText)
                    .onChange(of: inputText) {
                            searchResults = performSearch(text: inputText, in: characters)
//                            searchResults = textFeildCharacterSQL(of: inputText)
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
                            NavigationLink(destination: DictionarySingleCharacterView(character: character)) {
                                    CharacterTriple(character: character)
                                    .foregroundStyle(Color.accentColor)
                            } // navlink to dictionary
                        } // for each
                        
                        
                        if (searchResults != nil && searchResults!.isEmpty) {
                            Text("--\tNothing found...\t--")
                                .foregroundStyle(.accent)
                                .opacity(0.75)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
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
