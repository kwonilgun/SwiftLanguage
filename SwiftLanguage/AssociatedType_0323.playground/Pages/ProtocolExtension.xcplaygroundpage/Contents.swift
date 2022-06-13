//AssociatedType_0108.playground

import SwiftUI

//Associated type에 제약조건을 줄 수 있다. 예를들어, 다음 코드는 컨테이너의 항목들이 equatable해야 하는 Container 프로토콜을 정의한다.

//protocol Container {
//    associatedtype Item: Equatable
//    mutating func append(_ item: Item)
//    var count: Int { get }
//    subscript(i: Int) -> Item { get }
//}

//2022년 6월 13일 이렇게 제약 조건을 줄 수 있다. 일반적으로 프로토콜의 제네릭을 associatedtype을 통해서 구현할 수 가 있다. 이 제네릭 PlaceHolder가 되고 extension을 통해서 제야글 줄 수 있는 것을 보여주는 예제이다.

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


var stackOfInts = Stack<Int>()
stackOfInts.append(42)
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
////
///이 Element는 Stack 구조체의 PlaceHolder 이다. 그리고 Element에 Equatable의 제약을 둔다. 비교하기 위해서  ==, =!, 결국 Int, String, 기본 타입을 사용하도록 제약을 두는 것이다.
///
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
////프로토콜의 확장을 통해서 Container Item을 제약을 둔다. Item의 프로토콜의 PlaceHolder 역할을 한다. 결국 추론을
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
