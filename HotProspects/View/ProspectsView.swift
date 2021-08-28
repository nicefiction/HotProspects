// ProspectsView.swift
// SOURCE:
// https://www.hackingwithswift.com/books/ios-swiftui/sharing-data-across-tabs-using-environmentobject
// https://www.hackingwithswift.com/books/ios-swiftui/dynamically-filtering-a-swiftui-list
// https://www.hackingwithswift.com/books/ios-swiftui/scanning-qr-codes-with-swiftui
// https://www.hackingwithswift.com/books/ios-swiftui/adding-options-with-a-context-menu
// https://www.hackingwithswift.com/books/ios-swiftui/posting-notifications-to-the-lock-screen

// MARK: - LIBRARIES -

import SwiftUI
import CodeScanner
import UserNotifications



struct ProspectsView: View {
   
   // MARK: - NESTED TYPES
   
   enum FilterType {
      case none , contacted, uncontacted
   }
   
   
   
   // MARK: - PROPERTY OBSERVERS
   
   /// `3/3`We want all instances of `ProspectsView` to read that object back out of the environment
   /// when they are created :
   @EnvironmentObject var prospects: Prospects
   /// `NOTE`: When you use `@EnvironmentObject`
   /// you are explicitly telling SwiftUI
   /// that your object will exist in the environment
   /// by the time the view is created .
   /// If it isn’t present , your app will crash immediately
   /// – be careful , and treat it like an _implicitly unwrapped optional_ .
   @State private var isShowingScanner: Bool = false
   
   
   
   // MARK: - PROPERTIES
   
   let selected: FilterType
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   
   var title: String {
      
      switch selected {
      case ProspectsView.FilterType.none: return "Everyone"
      case ProspectsView.FilterType.contacted: return "Contacted"
      case ProspectsView.FilterType.uncontacted: return "Uncontacted"
      }
   }
   
   
   var filteredProspects: Array<Prospect> {
      
      switch selected {
      case ProspectsView.FilterType.none:
         return prospects.humans
      case ProspectsView.FilterType.contacted:
         return prospects.humans.filter { (prospect: Prospect) in
            prospect.hasBeenContacted
         }
      case ProspectsView.FilterType.uncontacted:
         return prospects.humans.filter { (prospect: Prospect) in
            !prospect.hasBeenContacted
         }
      }
   }
   
   
   // MARK: - BODY -
   
   var body: some View {
      
      NavigationView {
         List {
            ForEach(filteredProspects) { (prospect: Prospect) in
               VStack(alignment: .leading) {
                  Text(prospect.name)
                     .font(.headline)
                  Text(prospect.emailAddress)
                     .foregroundColor(.secondary)
               }
               .contextMenu(
                  ContextMenu(
                     menuItems: {
                        Button(prospect.hasBeenContacted ? "Mark Uncontacted" : "Mark Contacted",
                               action: {
                                 // prospect.hasBeenContacted.toggle()
                                 prospects.toggle(prospect)
                               })
                        if !prospect.hasBeenContacted {
                           Button("Remind Me") {
                              self.addNotification(for: prospect)
                           }
                        }
                     }))
               
            }
         }
         .navigationBarTitle(title)
         .navigationBarItems(
            trailing:
               Button(action: {
//                  let dorothy = Prospect()
//                  dorothy.emailAddress = "dorothy@oz.com"
//                  dorothy.name = "Dorothy Gale"
//                  self.prospects.humans.append(dorothy)
                  isShowingScanner.toggle()
               },
               label: {
                  Image(systemName: "qrcode.viewfinder")
                  Text("Scan")
               }))
         .sheet(isPresented: $isShowingScanner) {
             CodeScannerView(codeTypes: [.qr],
                             simulatedData: "Dorothy Gale\ndorothy@oz.com",
                             completion: self.handleScan)
         }
      }
   }
   
   
   
   // MARK: - METHODS
   
   func handleScan(result: Result<String, CodeScannerView.ScanError>) {
      
      self.isShowingScanner = false
      
      switch result {
      case .success(let code):
         let details = code.components(separatedBy: "\n")
         guard details.count == 2 else { return }
         
         let person = Prospect()
         person.name = details[0]
         person.emailAddress = details[1]
         
         /// When we write code like ...
         // self.prospects.humans.append(person)
         // self.prospects.save()
         /// we are breaking a software engineering principle known as _encapsulation_.
         /// This is the idea that we should limit
         /// how much external objects can read and write values inside a class or a struct ,
         /// and instead provide methods for reading (getters) and writing (setters) that data .
         /// In practical terms , this means
         /// rather than writing `self.prospects.humans.append(person)`
         /// we would instead create an `add()` method on the `Prospects` class ,
         /// so we could write code like this :
         self.prospects.add(person)
      case .failure:
         print("Scanning failed")
      }
   }
   
   
   func addNotification(for prospect: Prospect) {
      
      let center = UNUserNotificationCenter.current()
      
      let addRequest = {
         
         let content = UNMutableNotificationContent()
         content.title = "Contact \(prospect.name)"
         content.subtitle = prospect.emailAddress
         content.sound = UNNotificationSound.default

//           var dateComponents = DateComponents()
//           dateComponents.hour = 9 // which means it will trigger the next time 9am comes about.
//           let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
//                                                       repeats: false)
         /// `TIP`: For testing purposes ,
         /// I recommend you comment out that trigger code
         /// and replace it with the following , which shows the alert five seconds from now :
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                         repeats: false)
         
         let request = UNNotificationRequest(identifier: UUID().uuidString,
                                             content: content,
                                             trigger: trigger)
         center.add(request)
       }

      /// For the second part of that method
      /// we are going to use both `getNotificationSettings()` and `requestAuthorization()` together,
      /// to make sure we only schedule notifications when allowed .
      center.getNotificationSettings { settings in
         if settings.authorizationStatus == .authorized {
            addRequest()
         } else {
            center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
               if success {
                  addRequest()
               } else {
                  print("D'oh")
               }
            }
         }
      }
   }
}





// MARK: - PREVIEWS -

struct ProspectsView_Previews: PreviewProvider {

   static var previews: some View {

      ProspectsView(selected: ProspectsView.FilterType.none)
   }
}
