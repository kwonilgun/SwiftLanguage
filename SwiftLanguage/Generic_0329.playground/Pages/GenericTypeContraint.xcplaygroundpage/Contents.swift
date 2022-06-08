//: [Previous](@previous)

import Foundation

//The hypothetical function above has two type parameters. The first type parameter, T, has a type constraint that requires T to be a subclass of SomeClass. The second type parameter, U, has a type constraint that requires U to conform to the protocol SomeProtocol.

//

//func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}

//This function doesn’t compile as written above. The problem lies with the equality check, “if value == valueToFind”. Not every type in Swift can be compared with the equal to operator (==). If you create your own class or structure to represent a complex data model, for example, then the meaning of “equal to” for that class or structure isn’t something that Swift can guess for you. Because of this, it isn’t possible to guarantee that this code will work for every possible type T, and an appropriate error is reported when you try to compile the code.
//
//All is not lost, however. The Swift standard library defines a protocol called Equatable, which requires any conforming type to implement the equal to operator (==) and the not equal to operator (!=) to compare any two values of that type. All of Swift’s standard types automatically support the Equatable protocol.’

//제네릭 타입의 프로토콜 제약을 준다. 그렇게 함으로써 값의 비교를 자동적으로 한다. 

func findIndex<T: Equatable>(ofString valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}


let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
//print(strings.enumerated())
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// Prints "The index of llama is 2’

