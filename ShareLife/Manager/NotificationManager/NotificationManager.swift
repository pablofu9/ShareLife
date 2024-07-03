//
//  NotificationManager.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 3/7/24.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    
    static let shared = NotificationManager()
    @Published var authorizationStatus: UNAuthorizationStatus = .notDetermined

    
    override private init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    self.authorizationStatus = .authorized
                    UIApplication.shared.registerForRemoteNotifications()
                
                }
            } else {
                
                DispatchQueue.main.async {
                    self.authorizationStatus = .denied

                }
            }
        }
    }

    func hasNotificationsPermissions(completion: @escaping (Bool) -> ()) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let authorized = settings.authorizationStatus == .authorized
                    
            completion(authorized)
        }
    }
    
    
    func sendLocalNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.accessibilityLabel = "\(title): \(body)"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "Change", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                
                print("Error al enviar la notificación local: \(error.localizedDescription)")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }
}
