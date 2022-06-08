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
        
    //💇‍♀️ 2022년 6월 4일 -> 여기가 아주 중요하다. Task를 인스턴스화하는 경우는 바로 실행이 들어간다. 실행이 들어가서 시간이 걸리는 작업이 있는 경우 try await basicTask.value 이 실행 결과를 읽어오기 위해서 await를 통해서 기다리고 실행이 된 결과 값을 .value를 통해서 읽어오는 경우가 된다.
    
    do {
            print("2.")
            print(try await basicTask.value)
            print("실행안됨")
        } catch {
            print("4. Basic task failed with error: \(error)")
        }
    
}

// 6월 4일 : 여기서 Task를 만들어서 실행을 한다. 이것이 실행이 되면 쓰레드로 실행이 되고 비동기로 실행을 한다. 여기서
Task {
    do{
        print("1.")
        try await doSomething()
        print("5.")
    } catch {
        print(error)
    }
}

