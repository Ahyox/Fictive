//
//  Notification.swift
//  Fictive
//
//  Created by Prof Ahyox on 29/11/2020.
//

import Foundation
import UserNotifications

class Notification {
    var title:String = ""
    var subtitle:String = ""
    var body:String = ""
    let NOTIFICATION_ID = "fictive_notification"
    
    init(title:String, body:String) {
        self.title = title
        self.body = body
    }
    
    init(title:String, subtitle:String, body:String) {
        self.title = title
        self.subtitle = subtitle
        self.body = body
    }
    
    func notify() {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default
        

        // show this notification three (3) seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: NOTIFICATION_ID, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
