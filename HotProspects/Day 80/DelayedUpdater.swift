// DelayedUpdater.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/manually-publishing-observableobject-changes


// MARK: - LIBRARIES -

import SwiftUI


class DelayedUpdater: ObservableObject {

   // MARK: - PROPERTY WRAPPERS

   // @Published var value: Int = 0
   var value: Int = 0 {
      willSet {
         objectWillChange.send()
      }
   }



   // MARK: - INITIALIZER METHODS

   init() {
      for i in 0..<10 {
         DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
            /// `asyncAfter()` lets us specify when the attached closure should be run ,
            /// which means we can say _do this work after 1 second_ rather than _do this work now_.
            self.value += 1
         }
      }
   }
}





struct DelayedView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @ObservedObject var delayedUpdater = DelayedUpdater()
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      return Text("The value is \(delayedUpdater.value)")
         .font(.title)
   }
}





// MARK: - PREVIEWS -

struct DelayedView_Previews: PreviewProvider {
   
    static var previews: some View {
      
      DelayedView()
         .preferredColorScheme(.dark)
    }
}
