// PackageDependencies.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/adding-swift-package-dependencies-in-xcode

// MARK: - LIBRARIES -

import SwiftUI
import SamplePackage



struct PackageDependencies: View {
   
   // MARK: - PROPERTIES
   
   let possibleNumbers = Array<Int>(0...60)
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var results: String {
      
      let selectedNumbers = possibleNumbers.random(7) // Using the .random() method from the imported SamplePackage module/library.
      let sortedNumbers = selectedNumbers.sorted()
      let stringNumbers = sortedNumbers.map { (number: Int) in
         // return String(number) // OLIVIER
         String.init(number) // PAUL
      }
      return stringNumbers.joined(separator: " , ")
   }
   
   
   var body: some View {
      
      Text(results)
         .font(.title)
   }
}


/*
 let selected = possibleNumbers.random(7).sorted()
 let strings = selected.map(String.init)
 return strings.joined(separator: ", ")
 */


// MARK: - PREVIEWS -

struct PackageDependencies_Previews: PreviewProvider {
   
   static var previews: some View {
      
      PackageDependencies()
   }
}
