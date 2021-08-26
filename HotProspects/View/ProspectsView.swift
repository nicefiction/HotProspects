// ProspectsView.swift

// MARK: - LIBRARIES -

import SwiftUI



struct ProspectsView: View {
   
   // MARK: - NESTED TYPES
   
   enum FilterType {
      case none , contacted, uncontacted
   }
   
   
   
   // MARK: - PROPERTY OBSERVERS
   
   /// We want all instances of `ProspectsView` to read that object back out of the environment
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
   
   var body: some View {
      
      NavigationView {
         Text("\(prospects.humans.count) \(prospects.humans.count == 1 ? "human" : "humans")")
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
/*
 NavigationView {
     Text("People: \(prospects.people.count)")
         .navigationBarTitle(title)
         .navigationBarItems(trailing: Button(action: {
             let prospect = Prospect()
             prospect.name = "Paul Hudson"
             prospect.emailAddress = "paul@hackingwithswift.com"
             self.prospects.people.append(prospect)
         }) {
             Image(systemName: "qrcode.viewfinder")
             Text("Scan")
         })
 }
 */




// MARK: - PREVIEWS -

struct ProspectsView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      ProspectsView(selected: ProspectsView.FilterType.none)
   }
}
