//: [Previous](@previous)

import Foundation


//You can include a generic where clause on an associated type. For example, suppose you want to make a version of Container that includes an iterator, like what the Sequence protocol uses in the standard library. Here’s how you write that:’

//‘The generic where clause on Iterator requires that the iterator must traverse over elements of the same item type as the container’s items, regardless of the iterator’s type. The makeIterator() function provides access to a container’s iterator.
//For a protocol that inherits from another protocol, you add a constraint to an inherited associated type by including the generic where clause in the protocol declaration. For example, the following code declares a ComparableContainer protocol that requires Item to conform to Comparable:’


protocol Container {
    
    //Protocol의 place holder 이다.
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }

    //결국, IteratorProtocol을 준수하는 타입인  Iterator는 단지 PlaceHolder 의 역할을 하는 것이다.
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Self.Item
    
    //결국 Serial Place holder는 Container 프로토콜을 준수한다. 
    associatedtype Serial: Container where Serial.Item == Self.Item
    
    //IteratorProtocol을 준수하는 구조체 또는 클래스를 리턴하는 것이다.
    func makeIterator() -> Iterator
    
    //Container를 준수하는 구조체 또는 클래스를 리턴하는 것이다.
    func makeSerial() -> Serial
}


struct Stack: Container   {
    
    
    //typealias Serial = Int

    typealias Item = Int
    //typealias Iterator = Item
    
    func makeSerial() -> Stack {
        Stack()
    }
    
    var items = [Item]()
    
    mutating func push(_ item: Item) {
        items.append(item)
    }
    mutating func pop() -> Item {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Item) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Item {
        return items[i]
    }
    
    
    //인스턴스를 리턴한다.
    func makeIterator() -> ModelIterate {
        return ModelIterate(count: 5)
    }
}


let stack = Stack()
var dataArray = stack.makeIterator()

while let data = dataArray.next() {
    print(data)
}


struct SomeSequence: Sequence {
    var count: Int
    func makeIterator() -> ModelIterate {
        return ModelIterate(count: self.count)
        }
}

struct ModelIterate: IteratorProtocol {
    var count: Int
    
    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count + 1
        }
    }
}


var sequence = SomeSequence(count: 3).makeIterator()

while let data = sequence.next(){
    print(data, terminator: " ")
}
