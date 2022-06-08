//: [Previous](@previous)

import Foundation



//Escaping Closures
//A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.’

//클로저가 함수의 파라미터로 전달이 되고, 함수가 리턴된 이후에 불려지면 함수를 탈출했다고 한다. 파라미터로 클로저를 받는 함수를 선언을 할때, 파라미터 타입 앞에 @escaping을 붙이면 된다.

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}


func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100}
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)   //200

completionHandlers.first?()  //100
print(instance.x)
