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
        }
    }
    
    init() {
        let db = DataBaseManager.shared // ignore warning :)
    }
}
