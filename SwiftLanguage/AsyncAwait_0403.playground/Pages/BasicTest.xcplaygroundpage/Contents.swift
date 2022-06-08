//: [Previous](@previous)

import Foundation



func fetchWeatherHistoryString(completion: @escaping ([Double]) -> String) {
    // Complex networking code here; we'll just send back 100,000 random temperatures
    DispatchQueue.global().async {
        let results = (1...100).map { _ in Double.random(in: -10...30) }
        let str = completion(results)
        print(str)
    }
}


//
fetchWeatherHistoryString { (records:[Double]) -> (String) in
    for record in records {
        print(record)
    }
    return "완료"
}


func doRegularWork() {
    Task {
        
    }
}

doRegularWork()


//이것은 @escaping 클로저를 이용해서 Async를 구현한 것이다. 
//func fetchWeatherHistory(completion: @escaping ([Double]) -> Void) {
//    // Complex networking code here; we'll just send back 100,000 random temperatures
//    DispatchQueue.global().async {
//        let results = (1...100).map { _ in Double.random(in: -10...30) }
//        completion(results)
//    }
//}
//
//
////
//fetchWeatherHistory { records in
//    for record in records {
//        print(record)
//    }
//}
