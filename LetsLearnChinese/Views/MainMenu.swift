//
//  ContentView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/8/25.
//

import SwiftUI

struct MainMenu: View {
    
    @State var emojis: Bool = true
    
    @State var construction: Bool = false
    
    var body: some View {
        
        let buttonHeight: CGFloat = 75
        
        NavigationStack{
            ZStack {
                
                DefaultBackground()
                
                VStack {
                    
                    TopBar()
                        .frame(alignment: .top)
                    
                    ScrollView {
                        Spacer()
                        
                        Text("↓ Scroll Down ↓")
                            .foregroundStyle(.accent)
                            .opacity(0.75)
                            .padding(.top)
                            
                        Spacer()
                        
                        let viewByUnitsTxt = emojis ? "📚 View by Units 📖" : "View by Units"
                        homeMenuButton(text: viewByUnitsTxt, destination: ViewByUnit(), buttonHeight: buttonHeight)
                        
                        let srchTxt = emojis ? "🔎 Search Characters 🕵️‍♂️" : "Search Characters"
                        homeMenuButton(text: srchTxt, destination: AllCharView(), buttonHeight: buttonHeight)
                        
                        let ntcrdTxt = emojis ? "📓 Note Cards 🃏" : "Note Cards"
                        homeMenuButton(text: ntcrdTxt,
                                       destination: SelectUnitsView(title: "Note Cards",
                                        view: { binding in
                                                AnyView(NoteCardView(selectedUnits: binding)) // Pass the binding correctly
                                                },
                                        continueTo: "Note Cards"),
                                       buttonHeight: buttonHeight)
                        
                    if construction {
                        let prtclsTxt = emojis ? "✨ Particles 🌀" : "Particles"
                        homeMenuButton(text: prtclsTxt, destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                            .disabled(true)
                        
                        let sntncTxt = emojis ? "⚙️ Sntnc* Structure 🧩" : "Sentence Structure"
                        homeMenuButton(text: sntncTxt, destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                            .disabled(true)
                        
                        let dateTxt = emojis ? "🕰️ Dates and Time ⏳" : "Dates and Time"
                        homeMenuButton(text: dateTxt, destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                            .disabled(true)
                        
                        let writingTxt = emojis ? "✍️ Writing 📝" : "Writing"
                        homeMenuButton(text: writingTxt, destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                            .disabled(true)
                        
                        let mltplTxt = emojis ? "❓ Multiple Choice ✅" : "Multiple Choice"
                        homeMenuButton(text: mltplTxt, destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                            .disabled(true)
                        
                        let fishTxt = emojis ? "🐟 Fish Game 🎣" : "Fish Game"
                        homeMenuButton(text: fishTxt, destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                            .disabled(true)
                        
                        let reviewTxt = emojis ? "🧠 Review Exam 🎯" : "Review Exam"
                        homeMenuButton(text: reviewTxt, destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                            .disabled(true)
                    }
                        
                        let pinTxt = emojis ? "🩷 Favorites 🩷" : "Favorites"
                        homeMenuButton(text: pinTxt, destination: Favorites(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                    
                        let duckTxt = emojis ? "🥹 Emotional Duck 🦆" : "Emotional Duck"
                        homeMenuButton(text: duckTxt, destination: duckieView(), buttonHeight: buttonHeight)
                        
                    if construction {
                        let statTxt = emojis ? "📊 Statistics 📈" : "Statistics"
                        homeMenuButton(text: statTxt, destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                            .disabled(true)
                    }
                        
                        let abMeTxt = emojis ? "🧑‍💻 About Me 👋" : "About Me"
                        homeMenuButton(text: abMeTxt, destination: AboutMeView(), buttonHeight: buttonHeight)

                        HStack {
                            Toggle("Show Emojis", isOn: $emojis)
                                .toggleStyle(AccentToggleStyle())
                                
                            if emojis {
                                Text("😁")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 40)
                        .padding(.top)
                        
                        
                        withAnimation {
                            Toggle("Show *under-development*", isOn: $construction)
                                .toggleStyle(AccentToggleStyle())
                        }
                        
                        Spacer(minLength: 50)
                        
                        Text(":)")
                            .foregroundStyle(.accent)
                            .opacity(0.175)
                        Spacer(minLength: 50)
                    } // scroll
                    .padding(.bottom, 1) // For the bottom bar
                } // v
            } // z
        } // nav
    } // view body
} // view struct

func homeMenuButton<Destination: View>(
    text: String,
    destination: Destination,
    buttonHeight: CGFloat
) -> some View {
    NavigationLink(destination: destination){
        ZStack {
            Rectangle()
                .fill(Color.buttonEdge)
                .frame(height: buttonHeight)
                .cornerRadius(10)
            
            Rectangle()
                .fill(Color.buttonFill)
                .frame(height: buttonHeight - 10)
                .cornerRadius(10)
                .padding(.all, 4)
            
            
            Text(text)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .font(.custom("InknutAntiqua-Bold", size: UIScreen.main.bounds.width * 0.08 - 5))
                .lineLimit(1)
        } // z
    } // navlink
    .padding()
    .padding(.bottom, -25)
} // view


#Preview {
        MainMenu()
}
