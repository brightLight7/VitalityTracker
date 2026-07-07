import UserNotifications

class NotificationController: ObservableObject
{
    var showContinueWithoutNotificationsAlert = false
     var permissionStatusText: String? = nil
    static let shared = NotificationController()
    
    init(){}
    
    @Published var notificationsEnabled = false
    func requestPermission(completion: @escaping (Bool) -> Void)
    {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                DispatchQueue.main.async
                {
                    self.notificationsEnabled = granted
                    completion(granted)
                }
            }
    }
    
    func syncNotificationState()
    {
        UNUserNotificationCenter.current().getPendingNotificationRequests{requests in
            DispatchQueue.main.async
            {
                self.notificationsEnabled = requests.contains {$0.identifier == "dailyReminder"}
            }
        }
    }
    func removeDailyReminder()
    {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
    }
    
    func scheduleDailyReminder( hour: Int = 19, minute: Int = 0)
    {
        let center = UNUserNotificationCenter.current()
        removeDailyReminder()
        
        
        let content = UNMutableNotificationContent()
        content.title = "VitalityTracker"
        content.body = "You have pending habits to complete - keep going!"
        content.sound = .default
        
        var date = DateComponents()
        date.hour = hour
        date.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyReminder",
        content: content,
        trigger: trigger
        )
        
        center.add(request)
        { error in
            if let error = error
            {
                print("Failed to schedule reminder: \(error)")
            }
        }
    }
}
