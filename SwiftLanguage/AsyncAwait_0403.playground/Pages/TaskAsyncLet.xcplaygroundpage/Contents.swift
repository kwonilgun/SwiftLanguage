/*
 How to call an async function using async let
 Paul Hudson     @twostraws    November 28th 2021

 Updated for Xcode 13.3

 Sometimes you want to run several async operations at the same time then wait for their results to come back, and the easiest way to do that is with async let. This lets you start several async functions, all of which begin running immediately – it’s much more efficient than running them sequentially.

 A common example of where this is useful is when you have to make two or more network requests, none of which relate to each other. That is, if you need to get Thing X and Thing Y from a server, but you don’t need to wait for X to return before you start fetching Y.

 To demonstrate this, we could define a couple of structs to store data – one to store a user’s account data, and one to store all the messages in their inbox:
 
 async let는 여러개의 async 함수들을 동시에 동작하게 만든다. 기다리지 않고 동작을 시키고, await에서 기다린다. 
 */



import Foundation
import SwiftUI

struct User: Decodable {
    let id: UUID
    let name: String
    let age: Int
}

struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let message: String
}

func loadData() async {
    async let (userData, _) = URLSession.shared.data(from: URL(string: "https://hws.dev/user-24601.json")!)

    async let (messageData, _) = URLSession.shared.data(from: URL(string: "https://hws.dev/user-messages.json")!)

    do {
        let decoder = JSONDecoder()
        let user = try await decoder.decode(User.self, from: userData)
        let messages = try await decoder.decode([Message].self, from: messageData)
        print("User \(user.name) has \(messages.count) message(s).")
    } catch {
        print("Sorry, there was a network problem.")
    }
}

Task {
    await loadData()
}
