//: [Previous](@previous)

import Foundation
import SwiftUI

//The addition of async/await fits perfectly alongside try/catch, meaning that async functions and initializers can throw errors if needed. The only proviso here is that Swift enforces a particular order for the keywords, and that order is reversed between call site and function.

//For example, we might have functions that attempt to fetch a number of users from a server, and save them to disk, both of which might fail by throwing errors:

enum UserError: Error {
    case invalidCount, dataTooLong
}

func fetchUsers(count: Int) async throws -> [String] {
    if count > 3 {
        // Don't attempt to fetch too many users
        throw UserError.invalidCount
    }

    // Complex networking code here; we'll just send back up to `count` users
    return Array(["Antoni", "Karamo", "Tan"].prefix(count))
}

func save(users: [String]) async throws -> String {
    let savedUsers = users.joined(separator: ",")

    if savedUsers.count > 32 {
        throw UserError.dataTooLong
    } else {
        // Actual saving code would go here
        return "Saved \(savedUsers)!"
    }
}


func updateUsers() async {
    do {
        let users = try await fetchUsers(count: 3)
        let result = try await save(users: users)
        print(result)
    } catch {
        print("Oops!")
    }
}


//전용 타스크를 만들어서 중지를 시키고, await 를 한다.
func doRegularWork() {
    Task {
        await updateUsers()
    }
}

doRegularWork()

