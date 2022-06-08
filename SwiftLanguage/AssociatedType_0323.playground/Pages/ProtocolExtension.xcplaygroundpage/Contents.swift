//AssociatedType_0108.playground

import SwiftUI

//Associated type에 제약조건을 줄 수 있다. 예를들어, 다음 코드는 컨테이너의 항목들이 equatable해야 하는 Container 프로토콜을 정의한다.

//protocol Container {
//    associatedtype Item: Equatable
//    mutating func append(_ item: Item)
//    var count: Int { get }
//    subscript(i: Int) -> Item { get }
//}

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}



struct Stack<Element>: Container {
    // original Stack<Element> implementation
    typealias Item = Element
    
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
}

//이 프로토콜에서 Suffix 는 associated type 이고, 두가지 제약조건을 가진다. 먼저 SuffixableContainer 프로토콜을 준수해야하고, 이것은 결국 Container를 준수해야 한다. 그것의 Suffix.Item 컨테이너의 Item 타입과 같아야한다.

// 이것이 중요한 이유는 Suffix 도 타입이다. Suffix는 SuffixableContainer를 준수해야한다. SuffixableContainer는 또한  Container를  준수해야 한다. 결국 프로토콜도 또한 타입인 것이다.


var stackOfInts = Stack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)


var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
//
//var arrayOfStrings = ["uno", "dos", "tres"]
var arrayOfStrings = Stack<String>()
arrayOfStrings.push("uno")
arrayOfStrings.push("dos")
arrayOfStrings.push("tres")


// Prints "All items match.
//
//
////Stack 의 구조체의 확장 Stack<Element> 에서 <Element> 를 삭제해야 한다.
///이 Element는 구조체의 PlaceHolder 이다
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}
//
if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}

//
////프로토콜의 확장
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if stackOfInts.startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}

//
////특정 타입을 준수하는 Container 이다. 프로토콜의 확장이다.
//
extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}

var stackOfDoubles = Stack<Double>()
stackOfDoubles.push(40.0)
stackOfDoubles.push(50.0)
stackOfDoubles.push(60.0)

print(stackOfDoubles.average())


extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}


print(stackOfInts.average())
print(stackOfInts.endsWith(70))
