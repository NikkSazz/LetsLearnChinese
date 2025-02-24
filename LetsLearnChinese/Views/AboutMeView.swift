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
                        Spacer() // keep
                        
                        AboutMeHeader(text: "About Me", fontSize: bigSize)
                        
                        AboutMeParagraph(text: "Hi,  I’m Nikolai Sazonov,   18-year-old Mathematics and Computer Science major at Hobart College,  Class of  2028.", fontSize: smallSize)


                        AboutMeHeader(text: "Why I built This App", fontSize: bigSize)
                        
                        AboutMeParagraph(text: "I struggled to find resources online that aligned with our school curriculum and the specific units we’re studying.", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "I’ve been into programming since middle school, when I started writing custom code for the game Terraria using C#. I made my own weapons, armor, enemies, (avaliable on TModLoader)", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "Building an iOS app is a valuable addition to my portfolio, showcasing my skills with Apple Development Tools, Swift Language, and application of  Math, Programming Fundamentals and Physics", fontSize: smallSize)
                        
                        
                        AboutMeHeader(text: "Tools I Used", fontSize: bigSize)
                        
                        AboutMeParagraph(text: "As a first time Apple Developer, I had to learn alot about Apple Ecosystem.", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "Here is a list of tools I used.", fontSize: smallSize)
                        
                        DividerStyle()
                        
                        AboutMeParagraph(text: "Swift,  SwiftUI,  XCode, Github, Git", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "Swift Data,  SQLite,  Swift Core", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "Core Data,  GRDB,  Python", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "SVG Repo,  StackOverflow,  Figma", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "SceneKit,  UIKit,  Blender,  SketchFab", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "SF Symbols,  SF Symbols,  SF Symbols", fontSize: smallSize)
  
                        DividerStyle()
                        
                        AboutMeParagraph(text: "What have I learned from this project.", fontSize: smallSize)
                        
                        AboutMeParagraph(text: " \"Debouncing\" optimization.", fontSize: smallSize)
                        
                        AboutMeParagraph(text: "Swift and SwiftUI using XCode.", fontSize: smallSize)
                        
                        DividerStyle()
                        
                        AboutMeHeader(text: "Contact Me", fontSize: bigSize)
                        
                        AboutMeParagraph(text: "This is where I write all my contact Information", fontSize: smallSize)
                        
                        
                        LinksParagraph()
                        
                        
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

private struct AboutMeParagraph: View {
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

struct LinksParagraph: View {
    var body: some View {
        
        LinkStyle(text: "Email:", imgName: "EmailIcon", linkDestination: "https://malito:nsazonov9@gmail.com/", linkText: " Copy Email ", isCopyPaste: true)
        
        DividerStyle()
            
        LinkStyle(text: "Github:  ", imgName: "GithubIcon", linkDestination: "https://github.com/NikkSazz")
        
        DividerStyle()
            
        LinkStyle(text: "Repository:  ", imgName: "RepositoryIcon", linkDestination: "https://github.com/NikkSazz/LetsLearnChinese/tree/main/LetsLearnChinese")
        
        DividerStyle()
        
        LinkStyle(text: "LinkedIn:  ", imgName: "LinkedInIcon", linkDestination: "https://www.linkedin.com/in/nikolai-sazonov-9a7218331/")
        
        DividerStyle()
            
        LinkStyle(text: "Instagram:  ", imgName: "InstagramIcon", linkDestination: "www.instagram.com/nikksazz/", linkText: "@NikkSazz")
        
        DividerStyle()
            
        LinkStyle(text: "League of Legends:", noImage: true, linkDestination: "AyaMaya#maya", linkText: "AyaMaya#maya", isCopyPaste: true)
    }
}

struct LinkStyle: View {
    var text: String = "No Text :("
    var imgName: String = ""
    var noImage: Bool = false
    var linkDestination: String = "www.instagram.com/nikksazz/"
    var linkText = "- Get Link -"
    var isCopyPaste = false
    
    
    var body: some View {
        HStack(spacing: 20) {
            let iconSize: CGFloat = 35
            if(!noImage){
                ZStack {
                    Image(imgName)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                        .foregroundStyle(.black)
                        .blur(radius: 10)
                        .offset(x: 4, y: 4)
                    
                    Image(imgName)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                        .foregroundStyle(.black)
                        .offset(x: 4, y: 4)
                    
                    Image(imgName)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                        .foregroundStyle(.accent)
                } // z
            }

            
            ZStack {
                Text(text)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .blur(radius: 4)
                
                Text(text)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .blur(radius: 1)
                    .offset(x: 3,y: 2)
                
                Text(text)
                    .foregroundStyle(.accent)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
            }
           
            
            if(isCopyPaste){
                Button(action: {
                    UIPasteboard.general.string = linkDestination
                }){
                    Text(linkText)
                    
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 5)
                        .background(.accent)
                        .opacity(0.8)
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            else{
                Link(linkText, destination: URL(string: linkDestination)!)
                    .foregroundStyle(.blue)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 5)
                    .background(.accent)
                    .opacity(0.8)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
        } // h
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    } // view
} // struct

struct DividerStyle: View {
    var body: some View {
        ZStack {
            Divider()
                .frame(height: 2)
                .background(.accent)
                .blur(radius: 10)
                .opacity(0.8)
            
            Divider()
                .frame(height: 2)
                .frame(maxWidth: .infinity)
                .background(.accent)
        }
    }
}

#Preview {
    AboutMeView()
}
