//: [Previous](@previous)

import Foundation


//Extending an Existing Type to Specify an Associated Type
//이미 존재하는 타입에 프로토콜을 준수하도록 확장할 수 있습니다. 여기에는 연관 타입을 사용하는 프로토콜도 포함합니다.
//
//Swift의 Array 타입은 이미 append(_:) 메소드, count 프로퍼티, 서브스크립트를 제공합니다. 이 3가지 기능은 Container 프로토콜 요구사항과 일치합니다. 이는 간단히 Array가 이 프로토콜을 준수하도록 선언만 해주면 Array가 Container를 준수하도록 확장할 수 있다는 것을 의미합니다. 이는 다음과 같이 빈 익스텐션을 정의하면 됩니다.


protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


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




protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
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

print(suffix)


extension Container where Item : Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}


//Extending an Existing Type to Specify an Associated Type
//이미 존재하는 타입에 프로토콜을 준수하도록 확장할 수 있습니다. 여기에는 연관 타입을 사용하는 프로토콜도 포함합니다.
//
//Swift의 Array 타입은 이미 append(_:) 메소드, count 프로퍼티, 서브스크립트를 제공합니다. 이 3가지 기능은 Container 프로토콜 요구사항과 일치합니다. 이는 간단히 Array가 이 프로토콜을 준수하도록 선언만 해주면 Array가 Container를 준수하도록 확장할 수 있다는 것을 의미합니다. 이는 다음과 같이 빈 익스텐션을 정의하면 됩니다.


//이부분이 중요하다. 이것이 있어야 위의 extension Container 가 유효하게 된다.
extension Array: Container{ }

if [0,9,8].startsWith(0) {
    print("0이 시작한다. ")
}
else {
    print("존재하지 않는다. ")
}


extension Container where Item == Double {
    func average() -> Item {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average())
// Prints "648.9"

extension Container where Item == Int {
    func sum(start: Item) -> Item {
        var sum = start
        
        for i in 0..<count {
            sum += self[i]
        }
        return sum
    }
}

print([1,2,3].sum(start: 10))

extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result: [Item] = []
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}

print(stackOfInts[[1,2]])  //Container 의 extension으로 substript를 구현해서
let seq:[Int] = [1,3,4]     //Array를 구현해서 sequence를 indexing 하는 문제
print(seq[[1,2]])
