//
//  ProgressBar.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/16/25.
//

import SwiftUI

import SwiftUI

class ProgressViewModel: ObservableObject {
    public let selectedUnits: Set<Int>
    
    init(units selectedUnits: Set<Int>) {
        print("In progressViewModel \n Selected Units:\(selectedUnits)")
        self.selectedUnits = selectedUnits
        self.progress = 0.0 // will this fix it?
    }
    
    @Published public var dontRepeat = false {
        didSet {
            if dontRepeat {
                print("dontRepeat is now true")
                listDoneAmount = 0
                progressList.removeAll()
                setListFor(units: selectedUnits)
            }
            else {
                print("dontRepeat is now false")
            }
        }
    }
    
    @Published public var progress: Double = 0.0 {
        didSet {
            // Restrict the value between 0.0 and 1.0
            if progress < 0.0 {
                progress = 0.0
            } else if progress > 1.0 {
                progress = 1.0
            }
//            print("Progress: \(progress)")
            percentage = Int(progress * 100)
//            print("Changed percentage to \(percentage)")
        }
    }
    
    @Published public var percentage: Int = 0
    
    @Published public var listDoneAmount: Int = 0 {
        didSet {
            if(listLen > 0){
                print("listcount \(progressList.count)")
                print("Progress = \(listDoneAmount) / \(listLen)")
                progress = Double(listDoneAmount) / Double(listLen)
            }
            else {
                progress = 0.0
            }
        }
    }
    
    @Published public var listLen: Int = 0
    
    @Published public var progressList: [Character] = [] {
        didSet {
            print("\n--\tprogressList altered\n")
            
            if listLen == 0 {
                // Initialize listLen only once
                listLen = progressList.count
                print("List length is now \(listLen)")
            }
            
            else {
                listDoneAmount = listLen - progressList.count
                print("Done amount incremented to \(listDoneAmount)")
                print("\(listLen) - \(progressList.count)")
            }
        }
    }

    func appendBack(_ character: Character) {
        progressList.insert(character, at: 0)
        print("Inserted \(character.chinese)")
        listDoneAmount -= 2 // going to increase by one anyway
    }
    
    func setListFor(units : Set<Int>) {
        print("func 'setListFor' called")
            //temporary code
        let newList = getAllCharacters(from: units)
        progressList.removeAll()
        progressList.append(contentsOf: newList)
        
    }
}

struct AccentToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.body)
                .foregroundColor(.accent)

            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color.accentColor : Color.gray.opacity(0.4)) // Track color
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ?
                              Color.white :
                                Color.white.opacity(0.75)) // Thumb color
                        .shadow(radius: 1)
                        .padding(2)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut(duration: 0.4), value: configuration.isOn)
                ) // circle overlay
                .onTapGesture {
                    configuration.isOn.toggle()
                } // ontap of overlay
        } // H label, and toggle
        .padding(.horizontal)
    } // view
} // Custom Toggle Style Struct
