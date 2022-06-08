//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//‘When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that’s used as part of the protocol.’
//‘The actual type to use for that associated type isn’t specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.

//프로토콜을 정의할 때, 프로토콜 정의의 일부분으로 associated type 선언하는 것이 때로는 유용하다. 플레이스 홀드 이름을 제공한다.
//실제적인 타입은 프로토콜이 적용된 이후에 규정된다.

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//‘Here’s a version of the nongeneric IntStack type from Generic Types above, adapted to conform to the Container protocol:’

//Container protocol을 적용한 nongeneric 버전

struct InStack: Container {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


//‘Thanks to Swift’s type inference, you don’t actually need to declare a concrete Item of Int as part of the definition of IntStack. Because IntStack conforms to all of the requirements of the Container protocol, Swift can infer the appropriate Item to use, simply by looking at the type of the append(_:) method’s item parameter and the return type of the subscript. Indeed, if you delete the typealias Item = Int line from the code above, everything still works, because it’s clear what type should be used for Item.’

struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}


//‘This time, the type parameter Element is used as the type of the append(_:) method’s item parameter and the return type of the subscript. Swift can therefore infer that Element is the appropriate type to use as the Item for this particular container.

//스위프트는 추론한다. 
