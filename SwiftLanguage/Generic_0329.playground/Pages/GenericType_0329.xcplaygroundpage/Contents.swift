//: [Previous](@previous)

import Foundation

//제네릭 함수
//Type parameter: In the swapTwoValues(_:_:) example above, the placeholder type T is an example of a type parameter. Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).’


//Generic Types
//In addition to generic functions, Swift enables you to define your own generic types. These are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.’

//제네릭 함수외에, 제네릭 타입을 지정할 수 있다.  당신 자신의 제네릭 타입을 정의할 수 있다. 커스텀 클래스 구조체, 이넘들이 어떤 타입으로 지정할 수 있다.


struct IntStack {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}


//제네릭 버전 : Element가 placeholder 이다.
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings’


let fromTheTop = stackOfStrings.pop()
print(stackOfStrings)


//‘When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition. Instead, the type parameter list from the original type definition is available within the body of the extension, and the original type parameter names are used to refer to the type parameters from the original definition.

//Element는 extension에서 계속사용할 수 있다. extension 정의에서는 별도로 타입 파라미터 리스트를 제공하지 않는다. 

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem)")
}
