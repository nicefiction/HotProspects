// DisplayView.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/reading-custom-values-from-the-environment-with-environmentobject

// MARK: - LIBRARIES -

import SwiftUI



struct DisplayView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @EnvironmentObject var user: User
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      Text("Hello \(user.name)")
         .font(.title)
   }
}





// MARK: - PREVIEWS -

struct DisplayView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      DisplayView()
   }
}
