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

func unitChinese(unitName: String) -> String {
    switch unitName {
    case "Greetings":
        return "问好"
    case "Family":
        return "家庭"
    case "Dates and Time":
        return "时间"
    case "Hobbies":
        return "爱好"
    case "Visiting Friends":
        return "看朋友"
    case "Appointments":
        return "约时间"
    case "Studying":
        return "学中文"
    case "School Life":
        return "学校生活"
    case "Shopping":
        return "买东西"
    case "Transportation":
        return "交通"
    default:
        return "你好"
    }
}

func unitEnglish(unit_id: Int) -> String {
    switch unit_id {
    case 1:
        return "Greetings"
    case 2:
        return "Family"
    case 3:
        return "Dates and Time"
    case 4:
        return "Hobbies"
    case 5:
        return "Visiting Friends"
    case 6:
        return "Making Appointments"
    case 7:
        return "Studying Chinese"
    case 8:
        return "School Life"
    case 9:
        return "Shopping"
    case 10:
        return "Transportation"
    case 11:
        return "Talking about the Weather"
    case 12:
        return "Dining"
    case 13:
        return "Asking Directions"
    case 14:
        return "Birthday Party"
    case 15:
        return "Seeing a Doctor"
    case 16:
        return "Dating"
    case 17:
        return "Renting an Apartment"
    case 18:
        return "Sports"
    case 19:
        return "Travel"
    case 20:
        return "At the Airport"
    default:
        return "Unit"
    }
}
