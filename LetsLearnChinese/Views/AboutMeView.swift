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
        let smallSize: CGFloat = 13
        ZStack{
            DefaultBackground()
            
            VStack {
                TopBar(title: "Let's Learn 中文吧", subtitle: "About Me")
                    .frame(alignment: .top)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        Spacer()
                        
                        AboutMeHeader(text: "About Me", fontSize: bigSize)
                        
                        AboutMeParagraph(text: "Hi, I’m Nikolai Sazonov, 18-year-old Mathematics and Computer Science major at Hobart College '28.\nI’m also learning Chinese to challenge myself in a completely different field.", fontSize: smallSize)


                        AboutMeHeader(text: "Why I built This App", fontSize: bigSize)
                        
                        AboutMeParagraph(text: "I struggled to find resources online that aligned with our school curriculum and the specific units we’re studying.", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "I’ve been into programming since middle school, when I started writing custom code for the game Terraria using C#. I made my own weapons, armor, enemies, (avaliable on TModLoader)", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "Building an iOS app is a valuable addition to my portfolio, showcasing my skills with Apple Development Tools, Swift Language, and application of Programming Fundamentals", fontSize: smallSize)
                        
                        
                        AboutMeHeader(text: "Tools I Used", fontSize: bigSize)
                        
                        AboutMeParagraph(text: "As a first time Apple Developer, I had to learn alot about Apple Ecosystem.", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "Swift,  SwiftUI,  XCode, Figma, Git", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "Swift Data,  SQLite,  Visual Studio", fontSize: smallSize)
  
                        
                        AboutMeHeader(text: "Contact Me", fontSize: bigSize)
                        
                        AboutMeParagraph(text: "This is where I write all my contact Information", fontSize: smallSize)
                        AboutMeParagraph(text: "This is where I write all my contact Information", fontSize: smallSize)
                        AboutMeParagraph(text: "This is where I write all my contact Information", fontSize: smallSize)
                        AboutMeParagraph(text: "This is where I write all my contact Information", fontSize: smallSize)
                        AboutMeParagraph(text: "This is where I write all my contact Information", fontSize: smallSize)
                        
                        Spacer(minLength: 50)
                        Text(":)")
                            .foregroundStyle(.accent)
                            .opacity(0.125)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer(minLength: 50)

                    } // v
                    .frame(maxWidth: .infinity, alignment: .leading)
                } // scroll
                .padding(.horizontal, 35)
                .scrollIndicators(.hidden)
            } // v
            .padding(.bottom, 1)
        } // z
    } // view
    
    
} // struct

struct AboutMeHeader: View {
    var text: String // The text to display
    var fontSize: CGFloat

    var body: some View {
        ZStack {
            // Outer stroke
            Text(text)
                .font(.custom("InknutAntiqua-Bold", size: fontSize))
                .foregroundColor(.accent)
                .blur(radius: 1)
                .offset(x: 2, y: 1)

            // Inner fill
            Text(text)
                .font(.custom("InknutAntiqua-Bold", size: fontSize))
                .foregroundColor(.black)
        } // z

    }
}

struct AboutMeParagraph: View {
    var text: String = "NoText Given"
    var fontSize: CGFloat = 13
    
    var body: some View {
        ZStack {
            Text(text)
                .font(.custom("InknutAntiqua-Bold", size: fontSize))
                .foregroundColor(.black)
                .blur(radius: 1)
                .offset(x: 2, y: 2)
            
            Text(text)
                .font(.custom("InknutAntiqua-Bold", size: fontSize))
                .foregroundColor(.accent)

        }
        .padding(.leading, 15)
        .multilineTextAlignment(.trailing)
        .frame(maxWidth: .infinity)
    }
}

#Preview(){
    AboutMeView()
}
