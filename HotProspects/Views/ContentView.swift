// ContentView.swift

// MARK: - LIBRARIES -

import SwiftUI



struct ContentView: View {
   
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
   }
}





// MARK: - PREVIEWS -

struct ContentView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      ContentView()
   }
}
