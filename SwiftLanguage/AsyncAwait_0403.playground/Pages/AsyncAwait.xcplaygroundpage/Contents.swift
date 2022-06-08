//2022년 6월 3일 :
// await와 async의 관계를 구현했다. 이중에서 Task 인스턴스를 만들어서 실행을 하면 즉시 실행이 된다. 그리고 Task.sleep() 을 추가해서 Task를 중단되면 다른 타스크가 동작이 되게했다. async로 동작하기 때문에 메인을 그대로 진행이 되고 메인이 완료되고 나면 타스크들이 순차적으로 동작을 하게 된다.

import Foundation
import SwiftUI

//From Swift 5.5, we can now clean up our functions by marking them as asynchronously returning a value rather than relying on completion handlers, like this:

//completion handlers에 의존하는 것이 아니고 async로 쉽게 표현을 하게 한다

//💇‍♀️ async call 에러 수정
//synchrous 함수에서 async 함수를 콜하면 에러가 발생한다. async 함수는 자신을 중지시키거나 async를 부른함수를 중지시켜야 한다.
// 이부분은 즉 메인에서 async 함수를 콜하기 위해서는 타스크를 생성해서 별돌 콜을 해 주어야 한다. 별도 타스크를 생성해야 한다.




func fetchWeatherHistory() async -> [Double] {
    (1...10).map { _ in Double.random(in: -10...30) }
}

func calculateAverageTemperature(for records: [Double]) async -> Double {
    let total = records.reduce(0, +)
    let average = total / Double(records.count)
    return average
}

func upload(result: Double) async throws -> String {
    print("2: upload 진입")
    try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    return String(result)
}

func processWeather() async -> String {
    let records = await fetchWeatherHistory()
    let average = await calculateAverageTemperature(for: records)
    do {
       let response = try await upload(result: average)
       return response
    }
    catch {
        print(error)
        return "error"
    }
    //print("Server response: \(response)")
    //return response
}


//전용 타스크를 만들어서 중지를 시키고, await 를 한다. 
func doRegularWork() {
    
    //2022.6월 3일: 이것은 전용 타스크를 실행한다. Task를 즉시 실행하지만 async로 실행을 하고 실행을 기다리는 상태가 된다. sleeping이기 있기 때문에 실행을 중지하고 기다리고 있는 상태가 된다. sleeping 전까지는 실행하고 wait가 되면 다음 타스크 실행이 된다. 
    Task {
        await print("4: processWeather = \(processWeather())")
    }
    
    //타스크가 실행이 되는 것이다.
    Task {
        print("3.fetchWeatherHistory")
        print("==============")
        await print(fetchWeatherHistory())
        print("==============")
    }
    
    print("1. doRegularWokr")
}

doRegularWork()


//How to fix the error “async call in a function that does not support concurrency”
//Paul Hudson     @twostraws    November 28th 2021
//
//Updated for Xcode 13.2
//
//This error occurs when you’ve tried to call an async function from a synchronous function, which is not allowed in Swift – asynchronous functions must be able to suspend themselves and their callers, and synchronous functions simply don’t know how to do that.
//
//If your asynchronous work needs to be waited for, you don’t have much of a choice but to mark your current code as also being async so that you can use await as normal. However, sometimes this can result in a bit of an “async infection” – you mark one function as being async, which means its caller needs to be async too, as does its caller, and so on, until you’ve turned one error into 50.
//
//In this situation, you can create a dedicated Task to solve the problem. We’ll be covering this API in more detail later on, but here’s how it would look in your code:


/* Task 란:
When you create an instance of Task, you provide a closure that contains the work for that task to perform. Tasks can start running immediately after creation; you don’t explicitly start or schedule them. After creating a task, you use the instance to interact with it — for example, to wait for it to complete or to cancel it. It’s not a programming error to discard a reference to a task without waiting for that task to finish or canceling it. A task runs regardless of whether you keep a reference to it. However, if you discard the reference to a task, you give up the ability to wait for that task’s result or cancel the task.
 
To support operations on the current task, which can be either a detached task or child task, Task also exposes class methods like yield(). Because these methods are asynchronous, they’re always invoked as part of an existing task.
 
Only code that’s running as part of the task can interact with that task. To interact with the current task, you call one of the static methods on Task.
 
A task’s execution can be seen as a series of periods where the task ran. Each such period ends at a suspension point or the completion of the task. These periods of execution are represented by instances of PartialAsyncTask. Unless you’re implementing a custom executor, you don’t directly interact with partial tasks.
 */
