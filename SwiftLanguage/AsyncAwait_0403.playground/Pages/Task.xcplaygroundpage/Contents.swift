//: [Previous](@previous)
/*
 Tasks in Swift explained with code examples

 Tasks in Swift are part of the concurrency framework introduced at WWDC 2021. A task allows us to create a concurrent environment from a non-concurrent method, calling methods using async/await.

 When working with tasks for the first time, you might recognize familiarities between dispatch queues and tasks. Both allow dispatching work on a different thread with a specific priority. Yet, tasks are quite different and make our lives easier by taking away the verbosity from dispatch queues.
 */

// https://www.avanderlee.com/concurrency/tasks/

import Foundation
import SwiftUI

enum ExampleError: Error {
    case somethingIsWrong
    
}


func doSomething() async throws {
    
        let basicTask = Task(priority: .background) {
            // .. perform some work
            
            try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
            print("3.")
            throw ExampleError.somethingIsWrong
        }
        
    //๐โโ๏ธ 2022๋ 6์ 4์ผ -> ์ฌ๊ธฐ๊ฐ ์์ฃผ ์ค์ํ๋ค. Task๋ฅผ ์ธ์คํด์คํํ๋ ๊ฒฝ์ฐ๋ ๋ฐ๋ก ์คํ์ด ๋ค์ด๊ฐ๋ค. ์คํ์ด ๋ค์ด๊ฐ์ ์๊ฐ์ด ๊ฑธ๋ฆฌ๋ ์์์ด ์๋ ๊ฒฝ์ฐ try await basicTask.value ์ด ์คํ ๊ฒฐ๊ณผ๋ฅผ ์ฝ์ด์ค๊ธฐ ์ํด์ await๋ฅผ ํตํด์ ๊ธฐ๋ค๋ฆฌ๊ณ  ์คํ์ด ๋ ๊ฒฐ๊ณผ ๊ฐ์ .value๋ฅผ ํตํด์ ์ฝ์ด์ค๋ ๊ฒฝ์ฐ๊ฐ ๋๋ค.
    
    do {
            print("2.")
            print(try await basicTask.value)
            print("์คํ์๋จ")
        } catch {
            print("4. Basic task failed with error: \(error)")
        }
    
}

// 6์ 4์ผ : ์ฌ๊ธฐ์ Task๋ฅผ ๋ง๋ค์ด์ ์คํ์ ํ๋ค. ์ด๊ฒ์ด ์คํ์ด ๋๋ฉด ์ฐ๋ ๋๋ก ์คํ์ด ๋๊ณ  ๋น๋๊ธฐ๋ก ์คํ์ ํ๋ค. ์ฌ๊ธฐ์
Task {
    do{
        print("1.")
        try await doSomething()
        print("5.")
    } catch {
        print(error)
    }
}

