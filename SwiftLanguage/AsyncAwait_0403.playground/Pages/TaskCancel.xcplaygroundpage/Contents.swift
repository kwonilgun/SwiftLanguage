//: [Previous](@previous)

import Foundation
import SwiftUI

enum ExampleError: Error {
    case somethingIsWrong
    
}

func getAverageTemperature() async throws {
    let fetchTask = Task { () -> Double in
        let url = URL(string: "https://hws.dev/readings.json")!

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            

            let readings = try JSONDecoder().decode([Double].self, from: data)
            
            if Task.isCancelled { throw ExampleError.somethingIsWrong}
            
            let sum = readings.reduce(0, +)
            return sum / Double(readings.count)
        } catch {
            return 10
            //throw  ExampleError.somethingIsWrong
        }
    }

    fetchTask.cancel()

    let result = await fetchTask.value
    print("Average temperature: \(result)")
}

//let task = Task {
//    await getAverageTemperature()
//}
//
//await task.value
Task {
    do {
        try await getAverageTemperature()
    }
    catch {
        print(error)
    }
}
