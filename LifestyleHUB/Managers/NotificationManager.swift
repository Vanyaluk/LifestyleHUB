//
//  NotificationsManager.swift
//  LifestyleHUB
//
//  Created by Иван Лукъянычев on 25.03.2024.
//

import UIKit
import UserNotifications


final class NotificationManager {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func autorisationRequest() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
    }
    
    /// создание нового уведомления
    func createNewNotification(with uuid: UUID, title: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Через 15 минут"
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request)
    }
    
    /// удаление сообщения
    func deleteNotification(with uuid: UUID) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [uuid.uuidString])
    }
}
