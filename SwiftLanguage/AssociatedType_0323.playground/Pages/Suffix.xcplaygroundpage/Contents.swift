//AssociatedType_0108.playground

import SwiftUI

//Associated type에 제약조건을 줄 수 있다. 예를들어, 다음 코드는 컨테이너의 항목들이 equatable해야 하는 Container 프로토콜을 정의한다.

protocol Container {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}



struct Stack<Element: Equatable>: Container {
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

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}

var stackOfInts = Stack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)

let suffix = stackOfInts.suffix(2)
dump(suffix)
let suffixLast = stackOfInts.suffix(3)
print(suffixLast)
