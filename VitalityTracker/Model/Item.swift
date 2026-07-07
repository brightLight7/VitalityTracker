
import SwiftUI
import SwiftData

enum HabitTargetFrequency: String, Codable, CaseIterable
{
    case daily = "Daily"
    case threePerWeek = "3 times a week"
    case weekly = "Weekly"
    case everyTwoWeek = "Every fortnight"
}

@Model
class Item{
    var id: UUID
    var title: String = ""
    var isDone: Bool
    var createdDate: Date
    var targetFrequencyRaw: String
    var category: Category?
    
    var targetFrequency: HabitTargetFrequency
    {
        get { HabitTargetFrequency(rawValue: targetFrequencyRaw) ?? .daily}
        set { targetFrequencyRaw = newValue.rawValue}
    }
    
    init (title: String, createdDate: Date, category: Category?)
    {
        let createdDay = Calendar.current.startOfDay(for: createdDate)
        
        self.id = UUID()
        self.title = title
        self.isDone = false
        self.createdDate = createdDay
        self.targetFrequencyRaw = HabitTargetFrequency.daily.rawValue
        self.category = category
    }
}




