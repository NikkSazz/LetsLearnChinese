//
//  AboutMeView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/15/25.
//
import SwiftUI

struct AboutMeView: View {
    var body: some View{
        let bigSize: CGFloat = 20
        ZStack{
            DefaultBackground()
            
            VStack {
                TopBar(title: "Let's Learn 中文吧", subtitle: "About Me")
                    .padding(.bottom, -00)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ZStack {
                            // Outer stroke
                            Text("About Me")
                                .font(.custom("InknutAntiqua-Bold", size: bigSize))
                                .foregroundColor(.black)
                                .offset(x: 0, y: 0)
                                .blur(radius: 5)

                            // Inner fill
                            Text("About Me")
                                .font(.custom("InknutAntiqua-Bold", size: bigSize))
                                .foregroundColor(.accent)
                        }
                        
                        Text("This is where you can write more about yourself.")
                            .font(.body)
                            .padding(.horizontal, 16)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } // scroll
                .padding(.leading, 25)
                .padding(.top, -250)
            } // v
        } // z
    } // view
} // struct

#Preview(){
    AboutMeView()
}
