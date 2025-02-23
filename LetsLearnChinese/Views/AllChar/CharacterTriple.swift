//
//  CharacterTriple.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/23/25.
//

import Foundation
import SwiftUICore

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
