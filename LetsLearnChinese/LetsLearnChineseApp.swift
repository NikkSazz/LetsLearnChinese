//
//  LetsLearnChineseApp.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/8/25.
//

import SwiftUI
import SwiftData

@main
struct LetsLearnChineseApp: App {
    var body: some Scene {
        WindowGroup {
            MainMenu()
//                .modelContainer(for: [Unit.self, ChineseCharacter.self])
        }
    }
    
    init() {
//        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        DataBaseManager.shared
    }
}
