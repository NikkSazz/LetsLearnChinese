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
    }
    
    @Published public var dontRepeat = false {
        didSet {
            if dontRepeat {
                print("dontRepeat is now true")
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
            
            percentage = Int(progress * 100)
            print("Changed percentage to \(percentage)")
        }
    }
    
    @Published public var percentage: Int = 0
    
    @Published public var listDoneAmount: Int = 0 {
        didSet {
            progress = Double(listDoneAmount) / Double(listLen)
        }
    }
    
    @Published public var listLen: Int = 0
    
    @Published public var progressList: [Character] = [] {
        didSet {
            listLen = progressList.count
            print("listLen Count is now \(listLen)")
        }
    }
    
    func setListFor(units : Set<Int>) {
        print("func 'setListFor' called")
        
        // write code here to get each character
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
