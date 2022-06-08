//데이터 타입으로서의 함수

import Foundation
import Darwin

//함수를 데이터 타입으로 나타내는 방법
//(매개변수 타입 나열) -> 반환타입


func addTwo(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwo(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var ft: (Int, Int) -> Int = addTwo(_:_:)

print(ft(2,3))

ft = multiplyTwo(_:_:)
print(ft(2,4))


//전달 인자로 함수를 받는 함수

func printMath(ft: (Int, Int)->Int, a: Int, b: Int) -> Void {
    print(ft(a,b))
}

printMath(ft: multiplyTwo(_:_:), a: 10, b: 10)


//함수를 반환하는 경우

func chooseMathFt(_ toAdd: Bool) -> (Int, Int)->Int {
    toAdd ? addTwo(_:_:) : multiplyTwo(_:_:)
}

let res:(Int, Int)->Int = chooseMathFt(true)
print(res(3,4))


//‘Function Types as Return Types
//You can use a function type as the return type of another function. You do this by writing a complete function type immediately after the return arrow (->) of the returning function.’

func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!’

