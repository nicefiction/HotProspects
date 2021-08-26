// EditView.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/reading-custom-values-from-the-environment-with-environmentobject

// MARK: - LIBRARIES -

import SwiftUI



struct EditView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @EnvironmentObject var user: User
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      TextField("Name", text: $user.name)
         .textFieldStyle(RoundedBorderTextFieldStyle())
   }
}





// MARK: - PREVIEWS -

struct EditView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      EditView()
   }
}
