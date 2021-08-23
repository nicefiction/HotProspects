// MainView.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/reading-custom-values-from-the-environment-with-environmentobject

/**
 One complexity with environment objects is what constitutes a child,
 because what environment objects a view has access to depends on its parent views.
 For example, if view A has access to an environment object
 and view B is inside view A – i.e., view B is placed in the body property of A –
 then view B also has access to that environment object.
 This means if view A is a navigation view,
 then all views that are pushed onto the navigation stack have access to the same environment.
 However, if view A presents view B as a sheet
 then they don’t automatically share environment data, and we need to send it in by hand.
 Apple has described this sheet situation as a bug that they want to fix,
 so I’m hopeful this will change in a future update to SwiftUI.
 */

// MARK: - LIBRARIES -

import SwiftUI



struct MainView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   let user = User()
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      VStack {
//         EditView()
//            .environmentObject(user)
//         DisplayView()
//            .environmentObject(user)
         EditView()
         DisplayView()
      }
      .environmentObject(user)
      .padding()
   }
}





// MARK: - PREVIEWS -

struct MainView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      MainView()
   }
}
