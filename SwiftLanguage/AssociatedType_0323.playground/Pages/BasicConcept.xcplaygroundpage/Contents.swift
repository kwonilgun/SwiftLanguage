//: [Previous](@previous)

//Started code for this video:
// https://gist.github.com/pitt500/c759b...
import Foundation

// MARK: - Associated Types
// Placeholder name to a type that is used as part of a protocol.
// The actual type for the associated type isn't specified until the protocol is adopted.
// Use associatedtype keyword
/* // error ❌
protocol Stack<T> {
    var count: Int { get }
    mutating func push(_ element: Int)
    mutating func pop() -> Int?
}
*/
// We need a way to name our type without knowing anything about "specific" Element type.
// 플레이스 홀드 이다.
// 특별하게 타입을 지정하지 않고 제네릭하게 타입을 선언할 수 있다. 결국 프로토콜의 제네릭 타입인 것이다.

protocol Container {
    
    //프로토콜의 제네릭이다.
    associatedtype Element

    var count: Int { get }
    var textDescription: String { get }
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
    //func textDescription() -> String
}

struct IntStack: Container {
    private var values: [Int] = []

    // Optional once Element can be inferred
    //typealias Element = Int
    //추론을 통해서 Element가 Int 라는 것을 알 수 있다.

    var count: Int {
        values.count
    }
    var textDescription: String {
        var str = ""
        for value in values {
            str += "\(value) "
        }
        return str
    }

    mutating func push(_ element: Int) {
        values.append(element)
    }

    mutating func pop() -> Int? {
        values.popLast()
    }
}

var stack1 = IntStack()
stack1.push(1)
stack1.push(2)
stack1.push(3)
//print("stack1:\(stack1)")
print(stack1.textDescription)

// MARK: - Generic Type using a protocol with associated type
struct MyStack<Item>: Container {
    // Optional once Element can be inferred
    // 💇‍♀️->이부분이 핵심이다. associatedtype Element 가 제네릭 플레이스 홀드와 결합이 됨으로써 Int, String 스택을 모두 지원을 할 수 있다.
    
    typealias Element = Item

    private var values: [Element] = []

    var count: Int {
        return values.count
    }
    var textDescription: String {
        var str = ""
        for value in values {
            str += "\(value) "
        }
        return str
    }

    mutating func push(_ element: Element) {
        values.append(element)
    }

    mutating func pop() -> Element? {
        values.popLast()
    }
    
//    func textDescription() -> String {
//        var str = ""
//        for value in values {
//            str += "\(value) "
//        }
//        return str
//    }
}


var stack2 = MyStack<Int>()
stack2.push(1)
stack2.push(2)
stack2.push(3)
//print("stack2: \(stack2)")
print(stack2.textDescription)

var stack3 = MyStack<String>()
stack3.push("Hello")
stack3.push("World")
stack3.push("Everybody!")
//print("stack3:\(stack3)")
print(stack3.textDescription)


// MARK: - Extending from a protocol with associated types
// Array를 Stack 프로토콜 준수하고 기능을 구현하게 할 수 있다.
extension Array: Container {
    // Did you notice that associated type was inferred because placeholder type has the same name
    // like Array's one?
    
    mutating func push(_ element: Element) {
        self.append(element)
    }

    mutating func pop() -> Element? {
        self.popLast()
    }
    
    var textDescription: String {
        var str = ""
        for value in self {
            str += "\(value) "
        }
        return str
    }
    
//    func textDescription() -> String {
//        var str = ""
//        for data in self {
//            str += "\(data) "
//        }
//        return str
//    }
}

var array = Array<String>()
array.push("Hello")
array.push("World")

print(array.textDescription)

// MARK: - How to solve "Protocol 'Stack' can only be used as a generic constraint ..."?
//func executeOperation(stack: Stack) {  // error ❌
//
//}
// 이것이 에러가 발생하기 때문에 제네릭으로 constraint 즉 제약을 주는 하기의 방법으로 처리를 해야 한다.
// Correct way to use protocols with associated types ✅
func executeOperation<T: Container>(container: T) {

}


// MARK: - Where clause
// Enable you to define requirements on the type parameters for generic functions, types,
// and associated types.
func insert<T: Container>( param: inout T) where T.Element == Int {
    param.push(1)
}

func insert<T: Container, Value>(
    param: inout T,
    value: Value
) where T.Element == Value {
    param.push(value)
}

insert(param: &stack2, value: 10)
print(stack2.pop() ?? "Empty")


// MARK: - Extensions with Where Clauses (Contextual Where clauses)
extension MyStack where Element: Equatable {
    func isOnTop(_ value: Element) -> Bool {
        guard let last = values.last else {
            return false
        }

        // Referencing operator function '==' on 'Equatable'
        // requires that 'MyStack<Item>.Element' (aka 'Item') conform to 'Equatable'
        return value == last
    }
}

print(stack3.isOnTop("Everybody!"))
print(stack3.isOnTop("Hello"))

extension MyStack where Element == Int {
    func average() -> Double {
        var sum = 0.0

        for value in values {
            sum += Double(value)
        }

        return sum/Double(values.count)
    }
}

print(stack2.average())

//print(stack3.average) // You can't use average in the incorrect context ❌

// MARK: - Challenge: Merge two stacks
//중요한 것은 Container1.Element == Container2.Element Element가 같아야 한다. 즉 Element 가 Int 이던지 String 이던지 같아아만 한다.
//Some Stack은 Mystack 의 제네릭 구조체이기 때문에 어떤 타입이 리턴이 될지 모르기 때문에 즉 Int, String이 리턴이 될 수 있다. 
func merge<Container1: Container, Container2: Container>(
    _ c1: inout Container1,
    _ c2: inout Container2
) -> some Container where Container1.Element == Container2.Element {
    var newContainer = MyStack<Container1.Element>()

    while let value = c1.pop() {
        newContainer.push(value)
    }

    while let value = c2.pop() {
        newContainer.push(value)
    }

    return newContainer
}


//결국 하기와 같이 Int, String 으로 구별해서 할 수 있는 것은 where Container1.Element == Container2.Element  조건 이기 때문에 가능하다. 이것이 매우 매우 중요하다.


var stack4 = MyStack<Int>()
stack4.push(5)
stack4.push(8)
stack4.push(13)

var stack5 = MyStack<Int>()
stack5.push(1)
stack5.push(2)
stack5.push(3)

var stack6 = merge(&stack4, &stack5)

print("-----")
print(stack6.textDescription)


//while let value = stack6.pop() {
//    print("\(value)", terminator: " ")
//}


var stack7 = MyStack<String>()
stack7.push("A")
stack7.push("B")
stack7.push("C")

var stack8 = MyStack<String>()
stack8.push("D")
stack8.push("E")
stack8.push("F")

var stack9 = merge(&stack7, &stack8)

print("-----")
print(stack9.textDescription)
//while let value = stack9.pop() {
//    print("\(value)", terminator: " ")
//}
