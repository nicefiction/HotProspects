// ProspectsView.swift
// SOURCE:
// https://www.hackingwithswift.com/books/ios-swiftui/sharing-data-across-tabs-using-environmentobject
// https://www.hackingwithswift.com/books/ios-swiftui/dynamically-filtering-a-swiftui-list

// MARK: - LIBRARIES -

import SwiftUI



struct ProspectsView: View {
   
   // MARK: - NESTED TYPES
   
   enum FilterType {
      case none , contacted, uncontacted
   }
   
   
   
   // MARK: - PROPERTY OBSERVERS
   
   /// `3/3`We want all instances of `ProspectsView` to read that object back out of the environment
   /// when they are created :
   @EnvironmentObject var prospects: Prospects
   /// `NOTE`: When you use `@EnvironmentObject`
   /// you are explicitly telling SwiftUI
   /// that your object will exist in the environment
   /// by the time the view is created .
   /// If it isn’t present , your app will crash immediately
   /// – be careful , and treat it like an _implicitly unwrapped optional_ .
   
   
   
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
   
   
   var filteredProspects: Array<Prospect> {
      
      switch selected {
      case ProspectsView.FilterType.none:
         return prospects.humans
      case ProspectsView.FilterType.contacted:
         return prospects.humans.filter { (prospect: Prospect) in
            prospect.hasBeenContacted
         }
      case ProspectsView.FilterType.uncontacted:
         return prospects.humans.filter { (prospect: Prospect) in
            !prospect.hasBeenContacted
         }
      }
   }
   
   
   var body: some View {
      
      NavigationView {
         List {
            ForEach(filteredProspects) { (prospect: Prospect) in
               VStack(alignment: .leading) {
                  Text(prospect.name)
                     .font(.headline)
                  Text(prospect.emailAddress)
                     .foregroundColor(.secondary)
               }
            }
         }
         .navigationBarTitle(title)
         .navigationBarItems(
            trailing:
               Button(action: {
                  let dorothy = Prospect()
                  dorothy.emailAddress = "dorothy@oz.com"
                  dorothy.name = "Dorothy Gale"
                  self.prospects.humans.append(dorothy)
               },
               label: {
                  Image(systemName: "qrcode.viewfinder")
                  Text("Scan")
               }))
      }
   }
}





// MARK: - PREVIEWS -

struct ProspectsView_Previews: PreviewProvider {

   static var previews: some View {

      ProspectsView(selected: ProspectsView.FilterType.none)
   }
}
