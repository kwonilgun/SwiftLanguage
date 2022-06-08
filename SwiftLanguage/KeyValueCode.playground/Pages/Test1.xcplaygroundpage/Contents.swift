//: [Previous](@previous)

import Foundation

struct SomeStructure {
    let someValue: Int
    var someString: String
}


//키 경로를 사용하여 값에 액세스하려면, 키 경로를 모든 유형에서 사용할 수 있는 첨자(keyPath:) 첨자에 전달하십시오. 예를 들어:

let s = SomeStructure(someValue: 12, someString: "권일근")
let pathToProperty: KeyPath<SomeStructure, Int> = \SomeStructure.someValue
let pathToSomeString = \SomeStructure.someString

var typeOf = type(of: pathToProperty)

print(type(of: pathToProperty))
print(type(of: pathToSomeString))

let value = s[keyPath: pathToProperty]
let string = s[keyPath: pathToSomeString]


print(value)
print(string)




