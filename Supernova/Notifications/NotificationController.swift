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
    
    func requestUpcomingLaunchNotification(title: String, body: String, timeInterval: Double, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        let identifier = identifier
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
