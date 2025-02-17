//
//  NoteCardView.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/29/25.
//

import SwiftUI
import SQLite3

struct NoteCardView: View {
    
    @Binding var selectedUnits: Set<Int>
    @StateObject private var viewModel: ProgressViewModel

    init(selectedUnits: Binding<Set<Int>>) {
        self._selectedUnits = selectedUnits
        self._viewModel = StateObject(wrappedValue: ProgressViewModel(units: selectedUnits.wrappedValue))
    }
    
    /// Current Character used in the NoteCard
    @State var character: Character = Character(id: 1, chinese: "图书馆", english: "Library", pinyin: "túshūguǎn")
    
    /// Stack to ctrl+z back to previous Character
    @State var previousCharStack: [Character] = []
    
    /// Bottom button to hide the Character's Unit and ID
    @State var showUnit = true
    
    var body: some View {
        let animationDuration = 0.3
        ZStack{
            DefaultBackground()
                
            VStack {
                TopBar(title: "NoteCards", subtitle: "学习")
                
                Spacer()
                
                NoteCard(character: character, animationDuration: animationDuration)
                
                
                Button { // next random char
                    appendToPrevStack(character)
                                        
                    if viewModel.dontRepeat {
                        viewModel.progress += 0.1
                    }
                    
                    character = fetchRandomCharacter(from: selectedUnits)

                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(.buttonFill.opacity(0.75))
                        HStack{
                            Image(systemName: "arrowshape.right")
                            let text = viewModel.dontRepeat ? "Next Char" : "Next Random Char"
                            Text(text)
                                .transition(.slide) // Adds a fade-in/out transition
                                .animation(.bouncy(duration: 0.3), value: viewModel.dontRepeat)
                        } // H
                        .foregroundStyle(.black)
                    } // Z
                    .frame(height: 50)
                    .cornerRadius(10)
                    .padding(.horizontal)
                } // next rand char button
                
                HStack {
                    
                    NavigationLink (destination: DictionarySingleCharacterView(character: character)){
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.buttonFill.opacity(0.75))
                            HStack{
                                Image(systemName: "book.pages.fill")
                                
                                Text("Go to Dictionary")
                            } // H
                            .foregroundStyle(.black)
                        } // Z
                        .frame(height: 50)
                        .cornerRadius(10)
                    } // Dictionary label
                    
                    Button { // back button
                        character = previousCharStack.popLast() ?? Character(id: 56, chinese: "没有", english: "Doesnt Have", pinyin: "méi yǒu")
                        if viewModel.dontRepeat {
                            viewModel.progress -= 0.1
                        }
                    } label: {
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.buttonFill.opacity(0.75))
                            HStack{
                                Image(systemName: "arrowshape.left")
                                
                                Text("Previous")
                            } // H
                            .foregroundStyle(.black)
                        } // Z
                        .frame(height: 50)
                        .cornerRadius(10)
                    } // Previous button
                    
                } // H
                .padding(.horizontal)

                
                VStack {
                    
                    HStack{
                        Toggle("Don't Repeat", isOn: $viewModel.dontRepeat)
                            .toggleStyle(AccentToggleStyle())
                            .frame(alignment: .trailing)
                            .padding(.leading)
                            .onChange(of: viewModel.dontRepeat) {
                                viewModel.progress = 0.0
                           }
                        
                        
                        VStack {
                            ProgressView(value: viewModel.progress)
                                .frame(width: 170, alignment: .trailing)
                                
                            HStack {
                                Text("Progression...")
                                    .foregroundStyle(.accent.opacity(0.9))
                                    .font(.custom("Inknut-Antiqua-Bold", size: 10))
                                    .frame(alignment: .leading)
                                    .padding(.leading)
                               
                                Spacer()
                                
                                if viewModel.dontRepeat {
                                    Text("\(Int(viewModel.progress * 100))%")
                                        .foregroundStyle(.accent.opacity(0.9))
                                        .font(.custom("Inknut-Antiqua-Bold", size: 10))
                                        .frame(alignment: .trailing)
                                        .padding(.trailing)
                                }
                            } // h
                            .frame(width: 170)
                        }
                        .padding(.trailing)
                    }

                    
                    HStack {
                        Text("Selected Units:")
                            .font(.title)
                            .foregroundStyle(.black.opacity(0.5))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        ForEach(Array(selectedUnits).sorted(), id: \.self) { level in
                            Text("\(level)")
                        } // display level for each
                        
                        Spacer()
//                            .padding(.leading)
                    } // H Selected Units: 6 7 8
                    .foregroundStyle(.accent)
                    
                    Spacer() // Barely does anything
                    
                    HStack {
                    
                        Button {
                            showUnit.toggle()
                        } label: {
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(
                                        showUnit ?
                                            .accent :
                                        .buttonFill.opacity(0.75))
                                HStack{
                                    Text(showUnit ? "Hide" : "Show Unit and ID")
//                                    Text("Show Unit") // Old Version
                                } // H
                                .foregroundStyle(.black)
                            } // Z
                            .frame(height: 50)
                            .cornerRadius(10)
                            .padding(.leading, 50)
                            .padding(.trailing, showUnit ? 20 : 50)
                        } // Button ShowUnit
                        if showUnit{
                            if character.unit_id != nil {
                                Text("Unit: \(character.unit_id ?? 0)")
                                    .font(.system(size: 20))
                                    .frame(width: 75, alignment: .leading)
                            }
                            Text("ID: \(character.id)")
                                .frame(width: 75, alignment: .leading)
//                                .padding()
                            Spacer(minLength: 50)
                        }
                        
                    } // H showunit and id
                    .foregroundStyle(.accent)
                    
                    Spacer(minLength: 30)
                    
                } // V View units
                
            } // v
            .padding(.bottom, 1)
                
        }//z
        .onAppear(){
            character = fetchRandomCharacter(from: selectedUnits)
        } // on appear Z
        
    } // body
    
    func appendToPrevStack(_ c: Character) {
        previousCharStack.append(character)
        if previousCharStack.count > 10 {
            previousCharStack.removeFirst()
        }
    } // func appendToPrevStack
} // notecardview

#Preview {
    NoteCardView(selectedUnits: .constant([7]))
}
