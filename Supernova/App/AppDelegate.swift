//
//  AppDelegate.swift
//  Supernova
//
//  Created by Henrique Marques on 23/01/23.
//

import UIKit
import GoogleMobileAds
import YouTubeiOSPlayerHelper
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var notificationSend = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        UNUserNotificationCenter.current().delegate = self

        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        SpaceDevsInternetServices.sharedObjc.getFutureLauches(limit: 1, startsAt: 0) { result in
            switch result {
            case .success(let result):
                let fullHours = convertHoursForCountDownLaunchesFormatter(result?[0].windowStart ?? "", outPut: "HH:mm:ss")
                let timeInterval = fullHours.timeIntervalSince(Date())
                let convertion = Int(timeInterval)
                
                if convertion >= 0 {
                    self.notificationSend = true   
                    let notificationTrigger = convertion - 3600
                    let identifier = result?[0].name
                    
                    NotificationController.sharedObjc.requestUpcomingLaunchNotification(title: "\(result?[0].name ?? "") is almost launching", body: "Livestream is now available to come along and watch", timeInterval: Double(notificationTrigger).rounded(), identifier: identifier ?? "Default_Identifier")
                
                } else if convertion <= 0 {
                    print("Time has passed")
                }
            case .failure(_):
                print("Error")
            }
            
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    }
      
      func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

      }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {

    }
    
}
