//: [Previous](@previous)

import Foundation
import SwiftUI
//동기 (sync)
//작업을 동기적(synchronous)으로 실행한다는 것은 무엇을 의미할까요?
//만약 어떤 작업을 동기적으로 실행한다면, 해당 작업이 끝날 때까지 다른 작업들은 기다립니다.


//비동기 (async)
//반면 비동기(asynchronous) 로 작업을 실행한다면요?
//해당 작업이 끝나든 말든 신경 쓰지 않고 나머지 작업을 바로 실행합니다. 그래서 이미지 다운로드나 네트워킹 등 작업 시간이 오래걸리는 것들은 비동기로 처리하는게 일반적인 방식이었습니다. 메인 스레드 막혀서 사용자 이벤트 등을 못받으면 안되니까요!


//이때 “일을 비동기로 보내놓고 신경을 안쓰고 있는데.. 그럼 실제 해당 작업이 언제 끝나는지는 어떻게 알지?” 라는 의문점이 들 수 있는데요, Swift에서는 클로저를 통해 해당 시점을 알려줍니다. 이게 바로 보통 우리가 completionHandler 로 부르는 것입니다.

//Task & TaskGroup
//Task 인스턴스를 생성할 때 해당 Task가 수행할 작업을 포함하는 클로저를 함께 제공하게 됩니다. Task는 생성 직후 실행을 시작할 수 있습니다. 명시적으로 시작하거나 예약하지 않아도 됩니다. Task를 만들면 해당 인스턴스를 사용하여 작업과 상호작용합니다. 예를 들어 Task의 작업이 완료될 때까지 기다리거나 취소할 수 있습니다. Task의 작업이 완료될 때까지 기다리거나 취소할 때까지 기다리지 않고 Task에 대한 참조를 버리는 것은 프로그래밍적 에러가 아닙니다. Task는 참조 유지 여부에 관계없이 처리됩니다. 그러나 Task에 대한 참조를 버리면 해당 Task의 결과를 기다리거나 Task를 취소할 수 있는 기능을 포기하게 됩니다.


//작업을 실행하는 비동기 instance 이다.
//let basicTask = Task {
//    return "This is the result of the task"
//}
//
//let basicTest = Task {
//    print("Hello")
//}


//print(await basicTask.value)
enum TaskError: Error {
    case createError, runError
}

func executeTask() async throws -> () {
    let basicTask = Task {
        return "This is the result of the task"
    }
    
    try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    
    print(await basicTask.value)
}

func executeTest() async {
    let basicTest = Task(priority: .high) {
        //throw TaskError.createError
        throw TaskError.createError
    }
    
    
    let res = await basicTest.result
    
    
    switch res {
    case .success(let data) :
        print("성공\(data)")
    case .failure(let error) :
        print("에러:\(error)")
        
    }
}
    

//2022년 6월 3일: Task는 여기서 바로 실행이 되지만 await를 걸고 진행이 되어간다. 그리고 작업수행을 프린트하고 이후에 try await executeTask()가 실행이 된다. 비동기 실행에 대해서 
func doRegularWork() {
    Task {
        try await executeTask()
    }
    
    print("doRegulrWork() 작업 수행 함")
}

doRegularWork()

func doTestWork() {
    Task {
        await executeTest()
    }
}

doTestWork()
