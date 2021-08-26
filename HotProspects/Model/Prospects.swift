// Prospects.swift

// MARK: - LIBRARIES -

import SwiftUI



class Prospects: ObservableObject {
   
   // MARK: - PROPERTIES
   
   @Published var humans: Array<Prospect>
   
   
   
   // MARK: - INITIALIZERS
   
   init() { self.humans = Array<Prospect>() }
}
