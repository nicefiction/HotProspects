// ContentView.swift
// SOURCE:
// https://www.hackingwithswift.com/books/ios-swiftui/building-our-tab-bar
// https://www.hackingwithswift.com/books/ios-swiftui/sharing-data-across-tabs-using-environmentobject

// MARK: - LIBRARIES -

import SwiftUI



struct ContentView: View {
   
   // MARK: - PROPERTIES
   
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
