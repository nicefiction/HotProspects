// ControllingImageInterpolation.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/controlling-image-interpolation-in-swiftui

// MARK: - LIBRARIES -

import SwiftUI



struct ControllingImageInterpolation: View {
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      Image("example")
         /// Take a close look at the edges of the colors :
         /// they look jagged, but also blurry .
         /// The jagged part comes from the original image
         /// because it’s only 66x92 pixels in size ,
         /// but the blurry part is where SwiftUI is trying to blend the pixels
         /// as they are stretched to make the stretching less obvious .
         /// For situations just like this one ,
         /// SwiftUI gives us the `interpolation()` modifier
         /// that lets us control how pixel blending is applied :
         .interpolation(.none)
         /// This turns off image interpolation entirely ,
         /// so rather than blending pixels
         /// they just get scaled up with sharp edges .
         .resizable()
         .scaledToFit()
         .frame(maxHeight: .infinity)
         .edgesIgnoringSafeArea(.all)
      
   }
}





// MARK: - PREVIEWS -

struct ControllingImageInterpolation_Previews: PreviewProvider {
   
   static var previews: some View {
      
      ControllingImageInterpolation()
         .preferredColorScheme(.dark)
   }
}
