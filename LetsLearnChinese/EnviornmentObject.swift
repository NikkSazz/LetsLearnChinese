import SwiftUI
import SwiftData

struct EnviornmentObject: View {
    var body: some View {
        ZStack {
            DefaultBackground()
            
            VStack {
                Text("Hello")
                    .foregroundStyle(.accent)
                
                let v = StartDB()
                
                Text("Chin: \(v.0), Pinyin: \(v.1), Unit \(v.2)")
            }
        }
    }
}

func StartDB() -> (String, String, Int) {
    return ("你好", "NiHao", 1)
}

@Model class Character {
    @Attribute(.unique) var id: Int
    var chinese: String
    var english: String
    var pinyin: String
    var unitID: Int
    var type: CharacterType
    
    init(id: Int, chinese: String, english: String, pinyin: String, unitID: Int, type: CharacterType) {
        self.id = id
        self.chinese = chinese
        self.english = english
        self.pinyin = pinyin
        self.unitID = unitID
        self.type = type
    }
}

enum CharacterType: String, Codable, CaseIterable {
    case noun
    case verb
    case adjective
    case adverb
    case pronoun
    case conjunction
    case preposition
    case interjection
    case other
}
