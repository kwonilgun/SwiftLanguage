//: [Previous](@previous)

import Foundation

//Type Constraints
//The swapTwoValues(_:_:) function and the Stack type can work with any type. However, it’s sometimes useful to enforce certain type constraints on the types that can be used with generic functions and generic types. Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.’

// 제네릭 타입에 제약을 가하는 것이 유용할 때가 있다.


//Type Constraint Syntax
//You write type constraints by placing a single class or protocol constraint after a type parameter’s name, separated by a colon, as part of the type parameter list. The basic syntax for type constraints on a generic function is shown below (although the syntax is the same for generic types):

//어떤제약을 가하는 구문

//func someFunction<T: SomeClass, U: SomeProtocol> (someT: T, someU: U) {
//    // function body goes here
//}


func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

// Prints "The index of llama is 2’

//위의 함수는 string 에서만 유용한 것이 아니고 확장을 할 수 있다.
//T에 제약을 가한다. Equatable로

func findIndexE<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndexE(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex is an optional Int with no value, because 9.3 isn't in the array
let stringIndex = findIndexE(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex is an optional Int containing a value of 2’
