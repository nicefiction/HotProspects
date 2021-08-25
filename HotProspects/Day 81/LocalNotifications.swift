// LocalNotifications.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/scheduling-local-notifications

// MARK: - LIBRARIES -

import SwiftUI
import UserNotifications



struct LocalNotifications: View {
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      VStack(spacing: 30) {
         Button("Request Permission",
                action: {
                  UNUserNotificationCenter
                     .current()
                     .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                           print("All set!")
                        } else if let _error = error {
                           print(_error.localizedDescription)
                        }
                     }
                })
         Button("Schedule Notification",
                action: {
                  print("The Schedule Notification button was tapped.")
                  let content = UNMutableNotificationContent()
                  content.title = "Feed the hedgehog 🦔"
                  content.subtitle = "The hedgehog is hungry."
                  content.sound = UNNotificationSound.default
                  
                  // Show this notification five seconds from now :
                  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                                  repeats: false)
                  
                  // Choose a random identifier :
                  let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                      content: content,
                                                      trigger: trigger)
                  
                  // Add our notification request :
                  UNUserNotificationCenter.current().add(request)
                })
      }
   }
}





// MARK: - PREVIEWS -

struct LocalNotifications_Previews: PreviewProvider {
   
   static var previews: some View {
      
      LocalNotifications()
   }
}
