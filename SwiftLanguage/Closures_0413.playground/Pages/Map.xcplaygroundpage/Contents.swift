//: [Previous](@previous)

import SwiftUI

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

//실행 코드가 많이 있는 경우는 리턴 타입을 명확하게 해 주어야 한다. 
// number 를 지정해 줄 필요가 없다. 추론을 통해서 타입이 정해진다. 즉 Int 이다. 
let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

//
//{ number in
//    var number = number
//    var output = ""
//    repeat {
//        output = digitNames[number % 10]! + output
//        number /= 10
//    } while number > 0
//    return output
//
//}

//let strings = numbers.map { (number) -> String in
//    var number = number
//    var output = ""
//    repeat {
//        output = digitNames[number % 10]! + output
//        number /= 10
//    } while number > 0
//    return output
//}
