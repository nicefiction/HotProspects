// Prospects.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/adding-options-with-a-context-menu

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
   
   // MARK: - PROPERTIES
   
   @Published var humans: Array<Prospect>
   
   
   
   // MARK: - INITIALIZERS
   
   init() { self.humans = Array<Prospect>() }
   
   
   
   // MARK: METHODS
   
   func toggle(_ prospect: Prospect) {
      
      /// `TIP`You should call `objectWillChange.send()`
      /// _before_ changing your property ,
      /// to ensure SwiftUI gets its animations correct .
      objectWillChange.send()
      prospect.hasBeenContacted.toggle()
   }
}
