// User.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/reading-custom-values-from-the-environment-with-environmentobject

// MARK: - LIBRARIES -

import SwiftUI


class User: ObservableObject {
   
   @Published var name: String = "Dorothy Gale"
}
