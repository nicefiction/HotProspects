// Prospects.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/adding-options-with-a-context-menu
// https://www.hackingwithswift.com/books/ios-swiftui/saving-and-loading-data-with-userdefaults

// MARK: - LIBRARIES -

import SwiftUI



// MARK: - PROPSPECT -

class Prospect: Identifiable,
                Codable {
   
   var emailAddress: String = ""
   /// `fileprivate(set)`_This property can be read from anywhere, but only written from the current file_.
   /// It hasn’t affected our project here ,
   /// but it does help keep us safe in the future .
   /// If you were wondering why we put the Prospect and Prospects classes in the same file, now you know ! 
   fileprivate(set) var hasBeenContacted: Bool = false
   var id: UUID = UUID()
   var name: String = "Anonymous"
}





// MARK: - PROSPECTS -

class Prospects: ObservableObject {
   
   // MARK: - STATIC PROPERTIES
   
   static let saveKey: String = "SavedData"
   
   
   
   // MARK: - PROPERTIES
   
   /// We can use access control
   /// to stop external writes to the `humans` Array ,
   /// meaning that our views must use the `add()` method to add prospects :
   @Published private(set) var humans: Array<Prospect>
   
   
   
   // MARK: - INITIALIZERS
   
   init() {
      if let _data = UserDefaults.standard.data(forKey: Prospects.saveKey) {
         if let _decodedData = try? JSONDecoder().decode(Array<Prospect>.self,
                                                         from: _data) {
            self.humans = _decodedData
            return
         }
      }
      
      self.humans = Array<Prospect>()
   }
   
   
   
   // MARK: METHODS
   
   func toggle(_ prospect: Prospect) {
      
      /// `TIP`You should call `objectWillChange.send()`
      /// _before_ changing your property ,
      /// to ensure SwiftUI gets its animations correct .
      objectWillChange.send()
      prospect.hasBeenContacted.toggle()
      
      save()
   }
   
   
   private func save() {
      
      if let _encodedData = try? JSONEncoder().encode(humans) {
         UserDefaults.standard.set(_encodedData,
                                   forKey: Prospects.saveKey)
      }
   }
   
   
   func add(_ prospect: Prospect) {
      
      humans.append(prospect)
      save()
   }
}
