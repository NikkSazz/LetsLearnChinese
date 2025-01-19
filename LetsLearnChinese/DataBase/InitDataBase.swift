//
//  InitDataBase.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/19/25.
//

import SwiftData
import Foundation

@Model class Unit {
    @Attribute(.unique) var id: Int
    var name:String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

@Model class ChineseCharacter {
    @Attribute(.unique) var id: Int
    var character: String
    var unitId: Int
    var english: [String]
    
    init(id: Int, character: String, unitId: Int, english: [String]) {
        self.id = UUID().hashValue
        self.character = character
        self.unitId = unitId
        self.english = english
    }
}
