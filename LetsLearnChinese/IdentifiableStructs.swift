//
//  IdentifiableStructs.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 2/21/25.
//

import Foundation

struct Character: Identifiable {
    let id: Int
    let chinese: String
    let english: String
    let pinyin: String
    let unit_id: Int?
    let type: String?
    
    init(id: Int, chinese: String, english: String, pinyin: String, unit_id: Int? = nil, type: String? = nil) {
        self.id = id
        self.chinese = chinese
        self.english = english
        self.pinyin = pinyin
        self.unit_id = unit_id
        self.type = type
    }
    
}
