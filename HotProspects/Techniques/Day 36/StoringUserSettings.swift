// StoringUserSettings.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/storing-user-settings-with-userdefaults

// MARK: - LIBRARIES -

import SwiftUI



struct StoringUserSettings: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   /// `STEP 2`Reading the data back .
   /// Rather than start with `tapCount` set to `0`
   /// we should instead make it read the value back from `UserDefaults`
   /// like this :
   @State private var tapCount: Int = UserDefaults.standard.integer(forKey: "Tap")
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      return Button(action: {
         tapCount += 1
         /// `STEP 1` We need to write the tap count to `UserDefaults` whenever it changes :
         UserDefaults.standard.setValue(tapCount,
                                        forKey: "Tap")
         /// `NOTE`This _key_ is case-sensitive
         /// just like regular Swift strings , and it’s important
         /// – we need to use the same key to read the data back out of UserDefaults .
      }, label: {
         Text("\(tapCount) \(tapCount == 1 ? "tap" : "taps")")
            .font(.largeTitle)
      })
   }
}





// MARK: - PREVIEWS -

struct StoringUserSettings_Previews: PreviewProvider {
   
   static var previews: some View {
      
      StoringUserSettings()
   }
}
