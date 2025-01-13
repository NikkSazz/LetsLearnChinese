//
//  NotImplimentedView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/14/25.
//

import SwiftUI

struct NotImplimentedView: View {
    var body: some View {
        ZStack{
            DefaultBackground()
            
            Text("Sorry, this\npart of the app is\nnot yet implimented")
                .foregroundStyle(.accent)
        }
        
    }
}

#Preview {
    NotImplimentedView()
}
