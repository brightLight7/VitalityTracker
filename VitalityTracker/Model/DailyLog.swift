
import Foundation

struct DailyLog: Identifiable, Codable
{
    var id: UUID = UUID()
    let date: Date
    var IDs_completedHabit: Set<UUID>
}

