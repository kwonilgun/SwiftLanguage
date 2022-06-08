//: [Previous](@previous)

//프로그램명 : AssociatedTypeEx

// 작성일 : 2021년 12월 14일

// Associated Type:
// 프로토콜을 정의할 때, 몇몇을 associated type으로 선언하면 매우 유용할 때가 있다. associated type은 프로토콜의 일부로 사용되는 타입을 위한 placeholder 역할을 한다. associated type은 정의하는 프로토콜이 채택되기 전까지 실제 타입이 명시되지 않는다. Associated type은 associatedtype 키워드를 사용해서 정의한다.
 

import SwiftUI



//여기 Container 프로토콜이 associated type의 Item과 함께 정의되어 있다.
/*
//이 프로토콜은 3가지의 요구사항을 정의한다.
//
//append(_:) 메소드를 통해서 컨테이너에 새로운 항목를 추가할 수 있어야한다.
//Int 타입을 리턴하는 count 프로퍼티를 통해서 컨테이너 들어있는 항목의 개수를 알 수 있어야한다.
//Int index 값을 취하는 subscript를 통해서 컨테이너의 각각의 항목을 가져올 수 있어야한다.

//Container 프로토콜은 항목들이 컨테이너에 어떻게 저장되어야 하는지, 어떤 타입이어야 하는지는 정의하고 있지 않고, 3가지 필수 요구사항만 정의한다. 이 프로토콜을 준수하는 타입은 세가지 필수 요구사항만 준수하면 원하는 기능을 더할 수 있다.
//
//Container 프로토콜을 준수하는 모든 타입은, 저장하는 값의 타입을 명시해야 하고, 이 값은 컨테이너에 추가될 수 있는 타입임을 보장해야한다. 뿐만 아니라 subscript를 통해 반환될 수 있는 타입이어야 함도 보장해야한다. 이를 위해서, Container 프로토콜은 구체적인 컨테이너의 타입을 알지 못하더라도, 컨테이너가 가질 요소들의 타입을 언급할 필요가 있다. 다시 말해, Container 프로토콜은 append(_:) 메소드를 통해 전달되는 값이 컨테이너의 요소와 같은 타입이어야 한다는 것과 컨테이너의 subscript 역시 컨테이너의 요소와 같은 타입이어야 한다는 것을 명시해야한다. 이를 위해서 Container 프로토콜은 associated type인 Item을 활용하는 것이다.
 */
//예제 코드
//여기 설명이 핵심이다. typealias Item = Int 를 사용하지 않아도 된다.
//IntStack 타입은 Container 프로토콜을 체택하고 세 가지 필수 요구사항을 준수하고 있고, associatedtype인 Item 사용하기 위해 Int 타입을 사용하고 있다. typealias Item = Int 는 프로토콜을 준수하기 위해서 추상 타입인 Item을 Int 로 바꿔 사용하기 위한 구문이다. Swift의 타입 추론 덕분에 이 구문은 생략 가능하다.

protocol Container {
    
    associatedtype Item
    
    mutating func append(_ item: Self.Item)
    var count: Int { get }
    subscript(i: Int) -> Self.Item { get }
}



//타입 추론으로 인해서 생략이 가능하다.
struct IntStack: Container {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    //typealias Item = Int. : !!!!!!!!!!생략이 가능한다.
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

var stackOp: IntStack = IntStack()

stackOp.push(100)
stackOp.push(200)
stackOp.push(300)
print("스택 갯수:\(stackOp.count)") //3
print(stackOp[0])    //100
print(stackOp[1])    //200
print(stackOp[2])    //300

print(stackOp.pop())     //300
print("스택 갯수:\(stackOp.count)") //3

//generic Stack 타입을 통해서도 Container 프로토콜을 준수할 수 있다.
//‘Swift can therefore infer that Element is the appropriate type to use as the Item for this particular container.’
//Swiftsms 타입 추론을 통해서 Element가 적절한 타입으로 사용이 될 수 있도록 한다.
struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
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

//generic place holder 를 이용해서 Stack을 형성했다.
var stringStack = Stack<String>()

stringStack.push("hello")
stringStack.push("world")
print(stringStack.count)   // 2
print(stringStack[1])      //world

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
print(intStack)
print(intStack[0])



//Adding Constraints to an Associated Type
protocol Example {
    associatedtype load: StringProtocol
}

struct Implement: Example {
    typealias load = String
    
    var someString : load
    
    var data : load {
        get { return self.someString }
        set{
            self.someString = newValue
        }
    }
}
var implement = Implement(someString: "Kwon")

implement.data = "SM Park"
print(implement.data)

struct Implement_1: Example {
    typealias load = String
    
}
