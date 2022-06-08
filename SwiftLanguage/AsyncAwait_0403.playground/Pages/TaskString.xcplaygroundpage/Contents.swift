//: [Previous](@previous)

import Foundation
import SwiftUI

enum ExampleError: Error {
    case somethingIsWrong
    
}




func doSomething() async throws {
    
    //💇‍♀️ 2022년 6월 4일: ()->String 이 부분이 중요하다. 결국 리턴하는 값을 지정해주는 것이 무엇보다 중요하다. 
    let basicTask = Task(priority: .background) { () -> String in
            // .. perform some work
            
            try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
            print("3.")
            //throw ExampleError.somethingIsWrong
            return "스티링을 리턴한다. "
        }
        
    //💇‍♀️ 2022년 6월 4일 -> 여기가 아주 중요하다. Task를 인스턴스화하는 경우는 바로 실행이 들어간다. 실행이 들어가서 시간이 걸리는 작업이 있는 경우 try await basicTask.value 이 실행 결과를 읽어오기 위해서 await를 통해서 기다리고 실행이 된 결과 값을 .value를 통해서 읽어오는 경우가 된다.
    
    do {
            print("2.")
            print(try await basicTask.value)
            print(await basicTask.result)
            print("4.")
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

