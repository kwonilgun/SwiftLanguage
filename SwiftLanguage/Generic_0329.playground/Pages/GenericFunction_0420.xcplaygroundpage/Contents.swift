//: [Previous](@previous)

import Foundation

//이 문제에 대한 해결책
//T의 실제 타입은 함수가 호출되는 그 순간 결정이 된다. Int 타입의 변수가 전달인자로 전달되었다면 T는 Int가 되고, String 타입의 변수가 전달인자로 전달되었다면 그 호출 순간에 T는 String이 된다.
//‘The generic version of the function uses a placeholder type name (called T, in this case) instead of an actual type name (such as Int, String, or Double). The placeholder type name doesn’t say anything about what T must be, but it does say that both a and b must be of the same type T, whatever T represents. The actual type to use in place of T is determined each time the swapTwoValues(_:_:) function is called.
// T는 placeholder 이고 같은 타입이 되어야 한다. T는 함수가 호출될 때 결정이 된다.


func swapTwoValues<T> (_ a: inout T, _ b:inout T) {
    let tempA: T = a
    a = b
    b = tempA
}

var numberOne: Int = 1
var numberTwo: Int = 100

swapTwoValues(&numberOne, &numberTwo)
print(numberOne, numberTwo)     // A, B  잘 작동이 된다.


var stringOne: String = "Hello"
var stringTwo: String = "World"
swapTwoValues(&stringOne, &stringTwo)
print(stringOne, stringTwo)
