import SwiftData
import SwiftUICore // for enviornment modelcontext

// Character Table
@Model
class Character {
    @Attribute(.unique) var id: Int
    var chinese: String
    var english: String
    var pinyin: String
    var unitID: Int
    var type: String
    
    init(id: Int, chinese: String, english: String, pinyin: String, unitID: Int, type: String) {
        self.id = id
        self.chinese = chinese
        self.english = english
        self.pinyin = pinyin
        self.unitID = unitID
        self.type = type
    }
}

func populateDatabase() {
    @Environment(\.modelContext) var modelContext
    
    // Example: Populate Character table
    let character = Character(id: 1, chinese: "你", english: "you", pinyin: "ni", unitID: 1, type: "noun")
    modelContext.insert(character)

    do {
        try modelContext.save()
        print("Database populated successfully!")
    } catch {
        print("Error saving data: \(error)")
    }
}

