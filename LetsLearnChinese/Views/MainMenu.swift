//
//  ContentView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/8/25.
//

import SwiftUI

struct MainMenu: View {
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
                        
                        homeMenuButton(text: "View by Units", destination: ViewByUnit(), buttonHeight: buttonHeight)
                        
                        homeMenuButton(text: "NoteCards",
                                       destination: SelectUnitsView(title: "Note Cards",
                                        view: { binding in
                                                AnyView(NoteCardView(selectedUnits: binding)) // Pass the binding correctly
                                                },
                                        continueTo: "Note Cards"),
                                       buttonHeight: buttonHeight)
                        
                        homeMenuButton(text: "All Characters", destination: AllCharView(), buttonHeight: buttonHeight)
                        
                        homeMenuButton(text: "Particles", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Sentence Structure", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Dates and Time", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Writing", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Multiple Choice", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Fish Game", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "Review Exam", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                                                
                        homeMenuButton(text: "Emotional Duck", destination: duckieView(), buttonHeight: buttonHeight)
                        
                        homeMenuButton(text: "Statistics", destination: NotImplimentedView(), buttonHeight: buttonHeight)
                            .opacity(0.5)
                        
                        homeMenuButton(text: "About Me", destination: AboutMeView(), buttonHeight: buttonHeight)

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
