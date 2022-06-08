//: [Previous](@previous)

import Foundation

//‘In contrast, opaque types preserve the identity of the underlying type. Swift can infer associated types, which lets you use an opaque return value in places where a protocol type can’t be used ‘as a return value. For example, here’s a version of the Container protocol from Generics:’

protocol Container {
    associatedtype Item
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
extension Array: Container { }


//‘You can’t use Container as the return type of a function because that protocol has an associated type. You also can’t use it as constraint in a generic return type because there isn’t enough information outside the function body to infer what the generic type needs to be.’

// Container를 함수의 리턴 타입으로 사용할 수가 없다. 왜냐하면 이 프로토콜이 associated type을 가지고 있기 때문이다. Container를 제네릭 리턴 타입으로 사용할 수가 없다. 제네릭 타입을 추론을 할 수 없기 때문이다. 그래서 불투명타입을 이용해서 처리를 할 수가 있다.

func makeOpaqueContainer<T>(item: T) -> some Container {
    return [item]
}
let opaqueContainer = makeOpaqueContainer(item: 12)
let twelve = opaqueContainer[0]
print(opaqueContainer)
print(type(of: twelve))
// Prints "Int’

let opaqueString = makeOpaqueContainer(item: "Hello")
let string = opaqueString[0]
print(type(of: string))
