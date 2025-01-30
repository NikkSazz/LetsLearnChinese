//
//  NoteCardView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/29/25.
//

import SwiftUI

struct NoteCardView: View {
    var body: some View {
        ZStack{
            DefaultBackground()
            
            Text("Note Card View")
                .foregroundStyle(.accent)
        }
    }
}

#Preview {
    NoteCardView()
}
