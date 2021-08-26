// CreatingTabs.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/creating-tabs-with-tabview-and-tabitem
/**
 `TIP`:
 It’s common to want to use NavigationView and TabView at the same time,
 but you should be careful:
 TabView should be the parent view,
 with the tabs inside it having a NavigationView as necessary,
 rather than the other way around.
 */

// MARK: - LIBRARIES -

import SwiftUI


struct CreatingTabs: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   // @State private var selectedTab: Int = 0
   @State private var selectedTab: String = ""
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      TabView(selection: $selectedTab) {
         Text("One")
            .onTapGesture {
               self.selectedTab = "Two"
            }
            .tabItem {
               Image(systemName: "star")
               Text("One")
            }
            /// We can attach a unique identifier to each view ,
            /// and use that for the selected tab :
            // .tag(0)
            .tag("One")
         Text("Two")
            .tabItem {
               Image(systemName: "star.fill")
               Text("Two")
            }
            // .tag(1)
            .tag("Two")
      }
      .font(.title)
   }
}





// MARK: - PREVIEWS -

struct CreatingTabs_Previews: PreviewProvider {
   
   static var previews: some View {
      
      CreatingTabs()
   }
}
