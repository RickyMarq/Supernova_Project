//
//  NotificationController.swift
//  Supernova
//
//  Created by Henrique Marques on 06/04/23.
//

import Foundation
import UserNotifications

class NotificationController {
    
    static let sharedObjc = NotificationController()
    
    private init() { }
    
    func requestTestNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
 //       content.subtitle = "Test Subtitle"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let identifier = UUID().uuidString + "Test Notification Identifier"
        let request = UNNotificationRequest(identifier: "Reminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func requestUpcomingLaunchNotification(title: String, body: String, timeInterval: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: "UpcomingLaunch", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
