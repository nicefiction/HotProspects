// ResultType.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/100/swiftui/80
// https://www.hackingwithswift.com/books/ios-swiftui/understanding-swifts-result-type

// MARK: INTRO
/**
 It is common to want a function to return some data if it was successful ,
 or return an error if it was unsuccessful .
 We usually model this using _throwing functions_ ,
 because if the function call succeeds
 we get data back ,
 but if an error is thrown
 then our _catch block_ is run ,
 so we can handle both independently .
 _But what if the function call doesn’t return immediately ?_
 */
/**
 Swift’s `Result` type is designed to solve the problem
 when you know thing A might be true or thing B might be true ,
 but exactly one can be true at any given time .
 If you imagine those as Boolean properties ,
 then each has two states (true and false) ,
 but together they have four states :

 A is false and B is false
 A is true and B is false
 A is false and B is true
 A is true and B is true
 
 If you know for sure that options 1 and 4 are never possible
 – that either A or B must be true but they can’t both be true –
 then you can immediately halve the complexity of your logic .
 */
/**
 If you recall ,
 I said the completion closure will either have `data` or `error` set to a value
 – it can’t be both , and it can’t be neither, because both those situations don’t make sense .
 However , because `URLSession` doesn’t enforce this constraint for us
 we need to write code to handle the impossible cases , just to make sure all bases are covered .
 Swift has a solution for this confusion , and it is a special data type called `Result`.
 This gives us the _either/or_ behavior we want .
 */

// MARK: - LIBRARIES -

import SwiftUI


enum NetworkError: Error {
   
   case badURL, requestFailed, unknown
}



struct ResultType: View {
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      Text("Hello, World!")
         .font(.title)
         .onAppear {
//            let url = URL(string: "https://www.apple.com")!
//            URLSession.shared.dataTask(with: url) { (data: Data?,
//                                                     urlResponse: URLResponse?,
//                                                     error: Error?) in
//               if data != nil {
//                  print("We have got data!")
//               } else if let _error = error {
//                  print(_error.localizedDescription)
//               }
//            }.resume()
            // ⭐️ :
            self.fetchData(from: "https://www.apple.com") { (result: Result) in
               switch result {
               case Result.success(let string): print(string)
               case Result.failure(let error):
                  switch error {
                  case NetworkError.badURL: print("Bad URL.")
                  case NetworkError.requestFailed: print("Failed request.")
                  case NetworkError.unknown: print("Unknown Error.")
                  }
               }
            }
         }
   }
   
   
   // MARK: METHODS
   
   /// 1 Send back a badURL error immediately :
   /// `NOTE` : The method’s return type is `Result<String, NetworkError>`,
   /// which is what says it will either be a string on success or a NetworkError value on failure .
   
//   func fetchData(from urlString: String)
//   -> Result<String, NetworkError> {
//
//      return Result.failure(NetworkError.badURL)
//   }
   
   /// This is still a blocking function cal l, albeit a very fast one .
   /// What we really want is a non-blocking call ,
   /// which means we can’t send back our `Result` as a return value .
   
//   func fetchData(from urlString: String,
//                  completion: (Result<String, NetworkError>) -> Void) {
//
//      completion(Result.failure(NetworkError.badURL))
//   }
   
   /// The reason we have a `completion` closure is that
   /// we can now make this method non-blocking:
   /// we can kick off some asynchronous work,
   /// make the method return
   /// so the rest of the code can continue,
   /// then call the `completion` closure at any point later on.
   /// When we pass a closure into a function,
   /// Swift needs to know whether it will be used immediately or whether it might be used later on.
   /// If it’s used immediately – the default – then Swift is happy to just run the closure.
   /// But if it’s used later on,
   /// then Swift lets us mark closure parameters as `@escaping`, which means
   /// _this closure might be used outside of the current run of this method ,_
   /// _so please keep its memory alive until we’re done ._
   /// In the case of our method ,
   /// we’re going to run some asynchronous work then call the closure when we’re done .
   /// That might happen immediately or it might take a few minutes; we don’t really care .
   
//   func fetchData(from urlString: String,
//                  completion: @escaping (Result<String, NetworkError>) -> Void) {
//
//      DispatchQueue.main.async {
//         completion(Result.failure(NetworkError.badURL))
//      }
//   }
   
   /// And now for our fourth version of the method
   /// we are going to blend our `Result` code with the `URLSession` code from earlier .
   /// This will have the exact same function signature
   /// – accepts a string and a closure, and returns nothing –
   /// but now we are going to call the completion closure in different ways :
   /// 1. If the URL is bad
   /// we’ll call `completion(.failure(.badURL))`.
   /// 2. If we get valid data back from our request
   /// we’ll convert it to a string
   /// then call `completion(.success(stringData))`.
   /// 3. If we get an error back from our request
   /// we’ll call `completion(.failure(.requestFailed))`.
   /// 4. If we somehow don’t get data or an error back
   /// then we’ll call `completion(.failure(.unknown))`.
   
   func fetchData(from urlString: String,
                  completion: @escaping (Result<String, NetworkError>) -> Void) {
      
      /// Check if the URL is OK ,
      /// otherwise return with a failure :
      guard let _url = URL(string: urlString)
      else {
         completion(Result.failure(NetworkError.badURL))
         return
      }
      
      URLSession.shared.dataTask(with: _url) { (data: Data?,
                                                urlResponse: URLResponse?,
                                                error: Error?) in
         /// The task has completed – push our work back to the main thread :
         DispatchQueue.main.async {
            /// Check the URL is OK , otherwise return with a failure :
            if let _data = data {
               /// Success , convert the data to a string and send it back :
               let stringData = String(decoding: _data, as: UTF8.self)
               completion(Result.success(stringData))
            } else if error != nil {
               /// Any sort of network failure :
               completion(Result.failure(NetworkError.requestFailed))
            } else {
               /// This ought not to be possible , yet here we are :
               completion(Result.failure(NetworkError.unknown))
            }
         }
      }.resume()
      /// What it gives us is a much cleaner API
      /// because we can now always be sure that we either get a string or an error
      /// – it’s impossible to get both of them or neither of them ,
      /// because that’s not how Result works . Even better ,
      /// if we do get an error
      /// then it must be one of the cases specified in `NetworkError`,
      /// which makes error handling much easier .
      /// `NOTE` All we have done so far is
      /// to write functions that use `Result`;
      /// we haven’t written anything that handles the `Result` that got sent back .
      /// Behind the scenes , `Result` is actually an `enum` with an _associated value_,
      /// and Swift has very particular syntax for dealing with these :
      /// we can switch on the `Result`,
      /// and write cases such as case `.success(let str)` to mean
      /// _if this was successful, pull out the string inside into a new constant called str._
      /// It is easier to see this all in action ,
      /// so let’s attach our new method to our `onAppear` closure , and handle all possible cases : ⭐️
      
   }
}





// MARK: - PREVIEWS -

struct ResultType_Previews: PreviewProvider {
   
   static var previews: some View {
      
      ResultType()
   }
}
