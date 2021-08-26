// ProspectsView.swift

// MARK: - LIBRARIES -

import SwiftUI



struct ProspectsView: View {
   
   // MARK: - NESTED TYPES
   
   enum FilterType {
      case none , contacted, uncontacted
   }
   
   
   
   // MARK: - PROPERTIES
   
   let selected: FilterType
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var title: String {
      
      switch selected {
      case ProspectsView.FilterType.none: return "Everyone"
      case ProspectsView.FilterType.contacted: return "Contacted"
      case ProspectsView.FilterType.uncontacted: return "Uncontacted"
      }
   }
   
   var body: some View {
      
      NavigationView {
         Text("Hello World")
            .navigationTitle(title)
      }
   }
}





// MARK: - PREVIEWS -

struct ProspectsView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      ProspectsView(selected: ProspectsView.FilterType.contacted)
   }
}
