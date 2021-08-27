// ContentView.swift
// SOURCE:
// https://www.hackingwithswift.com/books/ios-swiftui/building-our-tab-bar
// https://www.hackingwithswift.com/books/ios-swiftui/sharing-data-across-tabs-using-environmentobject

// MARK: - LIBRARIES -

import SwiftUI



struct ContentView: View {
   
   // MARK: - PROPERTIES
   
   /// `1/3`First ,
   /// we need to add a property to ContentView
   /// that creates and stores a single instance of the Prospects class :
   var prospects: Prospects = Prospects()
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      TabView {
         ProspectsView(selected: ProspectsView.FilterType.none)
            .tabItem {
               Image(systemName: "person.3")
               Text("Everyone")
            }
         ProspectsView(selected: ProspectsView.FilterType.contacted)
            .tabItem {
               Image(systemName: "checkmark.circle")
               Text("Contacted")
            }
         ProspectsView(selected: ProspectsView.FilterType.uncontacted)
            .tabItem {
               Image(systemName: "questionmark.diamond")
               Text("Uncontacted")
            }
         MeView()
            .tabItem {
               Image(systemName: "person.crop.square")
               Text("Me")
            }
      }
      /// `2/3`Second ,
      /// we need to post that property into the SwiftUI environment ,
      /// so that all child views can access it . 
      /// Because tabs are considered children of the `TabView` they are inside ,
      /// if we add it to the environment for the `TabView`
      /// then all our `ProspectsView` instances will get that object .
      .environmentObject(prospects)
   }
}





// MARK: - PREVIEWS -

struct ContentView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      ContentView()
   }
}
