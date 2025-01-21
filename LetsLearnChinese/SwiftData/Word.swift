//
//  Word.swift
//  LetsLearnChinese
//
//  Created by Dmitry Sazonov on 1/21/25.
//

import SwiftData

@Model
class Word {
    var id: Int
    var character: String
    var pinyin: String
    var english: String
    var lesson: Int
    
    init(id: Int,
         character: String,
         pinyin: String,
         english: String,
         lesson: Int
    ) {
        self.id = id
        self.character = character
        self.pinyin = pinyin
        self.english = english
        self.lesson = lesson
    }
}
