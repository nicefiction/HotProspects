// ContextMenus.swift

// MARK: - LIBRARIES -

import SwiftUI



struct ContextMenus: View {
   
   // MARK: - PROPERTY WRAPPERS -
   
   @State private var backgroundColor: Color = Color.red
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      VStack {
         Text("Hello, World!")
            .font(.title)
            .padding()
            .background(backgroundColor)
         Text("Change Color")
            .contextMenu(ContextMenu(menuItems: {
               Button(action: {
                  backgroundColor = Color.blue
               }, label: {
                  Text("Blue")
                  Image(systemName: "checkmark.circle.fill")
               })
               Button(action: {
                  backgroundColor = Color.yellow
               }, label: {
                  Text("Yellow")
                  Image(systemName: "checkmark.circle.fill")
               })
               Button(action: {
                  backgroundColor = Color.green
               }, label: {
                  Text("Green")
                  Image(systemName: "checkmark.circle.fill")
                     .foregroundColor(.green)
               })
            }))
      }
   }
}





// MARK: - PREVIEWS -

struct ContextMenus_Previews: PreviewProvider {
   
   static var previews: some View {
      
      ContextMenus()
   }
}
