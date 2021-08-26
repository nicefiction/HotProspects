// Prospect.swift

// MARK: - LIBRARIES -

import SwiftUI


class Prospect: Identifiable,
                Codable {
   
   var emailAddress: String = ""
   var hasBeenContacted: Bool = false
   var id: UUID = UUID()
   var name: String = "Anonymous"
}
