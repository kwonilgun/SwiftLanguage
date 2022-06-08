//: [Previous](@previous)

import Foundation

protocol Container {
    associatedtype Element
    mutating func append(_ item: Element)
    var count: Int { get }
    mutating func pop() -> Element?
    //subscript(i: Int) -> Element { get }
}


//
struct Stack<Item>: Container {
    
    var items = [Item]()
    
    mutating func push(_ item: Item) {
        items.append(item)
    }
    mutating func pop() -> Item? {
        return items.removeLast()
    }
    mutating func append(_ item: Item) {
        self.push(item)
    }
    
    
    var count: Int {
        items.count
    }
    
//    subscript(i: Int) -> Item {
//        items[i]
//    }
    
    //typealias Element = Item
}


var stackInt = Stack<Int>()
stackInt.push(4)
stackInt.push(5)
stackInt.push(6)

var stackString = Stack<String>()
stackString.push("Hello")
stackString.push("World")
stackString.push("Everybody")

extension Array: Container {
    mutating func push(_ element: Element) {
        self.append(element)
    }
    
    mutating func pop() -> Element? {
        self.popLast()
    }
}
 
//Use protocols with associated types as type constraints in generics
// 제네릭의 타입 제약으로 associated type을 갖는 프로토콜을 이용하라.
func executeOperation<T: Container>(stack: T) -> Int {
    stack.count
}

let count =  executeOperation(stack: stackInt)
print(count)


var array = [1,2,3]
array.push(5)
print(array)
array.popLast()
print(array)
