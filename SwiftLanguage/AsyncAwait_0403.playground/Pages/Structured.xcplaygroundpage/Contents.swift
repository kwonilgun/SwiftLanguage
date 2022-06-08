//: [Previous](@previous)

import Foundation
import SwiftUI

//introduces a whole range of approaches to execute, cancel, and monitor concurrent operations in Swift, and builds upon the work introduced by async/await and async sequences

//For easier demonstration purposes, here are a couple of example functions we can work with – an async function to simulate fetching a certain number of weather readings for a particular location, and a synchronous function to calculate which number lies at a particular position in the Fibonacci sequence:

enum LocationError: Error {
    case unknown
}

func getWeatherReadings(for location: String) async throws -> [Double] {
    switch location {
    case "London":
        return (1...100).map { _ in Double.random(in: 6...26) }
    case "Rome":
        return (1...100).map { _ in Double.random(in: 10...32) }
    case "San Francisco":
        return (1...100).map { _ in Double.random(in: 12...20) }
    default:
        throw LocationError.unknown
    }
}



//전용 타스크를 만들어서 중지를 시키고, await 를 한다.
func doRegularWork() {
    Task {
        let weather = try await getWeatherReadings(for: "London")
        print(weather)
    }
}

doRegularWork()


