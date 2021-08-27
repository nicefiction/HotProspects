// MeView.swift
// SOURCE:
// https://www.hackingwithswift.com/books/ios-swiftui/generating-and-scaling-up-a-qr-code

// MARK: - LIBRARIES -

import SwiftUI
import CoreImage.CIFilterBuiltins // STEP 1



struct MeView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @State private var name: String = "Somename"
   @State private var emailAddress: String = "somename@email.com"
   
   
   
   // MARK: - PROPERTIES
   
   let context = CIContext() // STEP 2
   let filter = CIFilter.qrCodeGenerator() // STEP 2
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      NavigationView {
         VStack {
            Group {
               TextField("Name", text: $name)
                  .textContentType(.name)
                  .padding(.horizontal)
               TextField("Email address", text: $emailAddress)
                  .textContentType(.emailAddress)
                  .padding([.horizontal, .bottom])
            }
            .font(.title)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
               .interpolation(.none)
               .resizable()
               .scaledToFit()
               .frame(width: 200, height: 200)
            Spacer()
         }
         .navigationBarTitle("Me")
      }
   }
   
   
   
   // MARK: METHODS
   
   func generateQRCode(from string: String)
   -> UIImage {
      
      /// Our input for the method will be a string ,
      /// but the input for the filter is Data ,
      /// so we need to convert that :
      let data = Data(string.utf8)
      filter.setValue(data,
                      forKey: "inputMessage")
      
      /// Working with Core Image filters requires us
      /// to use `setValue(_:forKey:)` one or more times
      /// to provide input data ,
      /// then convert the output `CIImage` into a `CGImage` ,
      /// then that `CGImage` into a `UIImage` :
      if let outputImage = filter.outputImage {
         if let cgimg = context.createCGImage(outputImage,
                                              from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
         }
      }
      
      /// If conversion fails for any reason
      /// we’ll send back the `xmark.circle` image from SF Symbols .
      /// If that can’t be read – which is theoretically possible because SF Symbols is stringly typed –
      /// then we’ll send back an empty UIImage :
      return UIImage(systemName: "xmark.circle") ?? UIImage()
   }
}





// MARK: - PREVIEWS -

struct MeView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      MeView()
   }
}
