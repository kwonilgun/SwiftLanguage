//: [Previous](@previous)

import Foundation

//클로저는 정의된 둘러싸인 컨텍스트에서 상수와 변수를 캡처 (capture) 할 수 있습니다. 그러면 클로저는 상수와 변수를 정의한 원래 범위가 더이상 존재하지 않더라도 바디 내에서 해당 상수와 변수의 값을 참조하고 수정할 수 있습니다.

//amount 와 runningTotal을 캡쳐한다. 

func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

print(incrementByTen())  //10
print(incrementByTen())  //20
print(incrementByTen())  //30

let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven()) // returns a value of 7

//각각의 incrementer 함수는 언제 호출이 되더라도 자신만의 runningTotal  변수를 갖고 카운트하게 된다. 다른 함수의 영향도 전혀 받지 않는다. 각각 자신의 runningTotal의 참조를 미리 획득했기 때문이다.
//클로저는 참조 타입니다. 함수나 클로저를 상수나 변수에 할당할 때 마다 사실은 상수나 변수에 함수나 클로저의 참조를 설정하는 것이다.

let incrementByTenVar: (() -> Int) = makeIncrementer(forIncrement: 10)
let sameWithIncrementByTen: (()-> Int) = incrementByTenVar

let first = incrementByTenVar()
let second = sameWithIncrementByTen()

print(first)
print(second)
