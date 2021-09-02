// ArchivingSwiftObjects.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/archiving-swift-objects-with-codable
/// We want to _archive_ a custom type
/// so we can put it into `UserDefaults`,
/// then _unarchive_ it
/// when it comes back out from `UserDefaults`.

// MARK: - LIBRARIES -

import SwiftUI


// MARK: - struct ArchivingSwiftObjects -

struct ArchivingSwiftObjects: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @State private var dorothy: Human = Human(firstName: "Doorthy",
                                             lastName: "Gale")
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      Button(action: {
         /// ⭐️
         let jsonEncoder: JSONEncoder = JSONEncoder()
         /// To convert our user data into JSON data ,
         /// we need to call the `encode()` method on a `JSONEncoder` .
         if let _dorothy = try? jsonEncoder.encode(dorothy) {
            UserDefaults.standard.set(_dorothy,
                                      forKey: "Human")
         }
      }, label: {
         Text("Save Human")
            .font(.largeTitle)
      })
   }
}





// MARK: - struct Human -

/// When working with a type that only has simple properties
/// – strings, integers, Booleans, arrays of strings, and so on –
/// the only thing we need to do to support archiving and unarchiving is
/// add a conformance to `Codable` ,
/// like this :
struct Human: Codable {
   
   var firstName: String
   var lastName: String
}
/// Swift will automatically generate some code for us
/// that will archive and unarchive `Human` instances for us as needed ,
/// but we still need to tell Swift
/// _when_ to archive
/// and what to do with the data .
/// This part of the process is powered by a new type
/// called `JSONEncoder`⭐️





// MARK: - PREVIEWS -

struct ArchivingSwiftObjects_Previews: PreviewProvider {
   
   static var previews: some View {
      
      ArchivingSwiftObjects()
   }
}
