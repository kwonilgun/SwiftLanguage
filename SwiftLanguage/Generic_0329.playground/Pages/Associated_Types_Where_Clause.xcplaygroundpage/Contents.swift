

import Foundation

//‘When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that’s used as part of the protocol.’

//프로토콜을 정의할 때, 프로토콜 정의의 일부분으로 associated type 선언하는 것이 때로는 유용하다. 플레이스 홀드 이름을 제공한다. 

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    //subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

struct ModelIterate: IteratorProtocol {
    var counter: Int

    mutating func next() -> Int? {
        if counter == 0 {
            return nil
        } else {
            defer { counter -= 1 }
            return counter + 1
        }
    }
}

struct SimpleStack<Element> {
    typealias Iterator = ModelIterate
    //typealias Iterator = ModelIterate
    
    typealias Item = Element
    
    var items = [Item]()
    
    mutating func append(_ item: Item) {
        items.append(item)
    }
    //typealias Iterator =
    
    var count: Int { return items.count}
    
    func makeIterator() -> ModelIterate {

        return ModelIterate(counter: 3)

    }
}



