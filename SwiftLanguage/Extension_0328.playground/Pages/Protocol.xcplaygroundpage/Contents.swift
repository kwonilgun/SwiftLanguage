//: [Previous](@previous)

import Foundation

//코드 22-3 제네릭+프로토콜+익스텐션을 통한 재사용 가능한 코드 작성

protocol SelfPrintable {
    func printSelf()
}


//💇‍♀️ -> SelfPrintable 프로토콜을 준수하는 타입 중 Container 프로토콜도 준수하는 타입에만 이 익스텐션이 적용될 수 있따.
//그래서 items을 이용할 수 있게 된다.
extension SelfPrintable where Self: Container {
    func printSelf(){
        print(items)    //구현이되었다.
    }
}

//protocol Container: SelfPrintable {
protocol Container: SelfPrintable {
    associatedtype ItemType
    
    var items: [ItemType] { get set}
    var count: Int { get }
    
    mutating func append(item: ItemType)
    subscript(i: Int) -> ItemType {get}
}

extension Container {
    mutating func append(item: ItemType) {
        items.append(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> ItemType
    {
        return items[i]
    }
}


//프로토콜 초기 구현을 통해 기능을 구현한다면 프로토콜 채택만으로 타입에 기능을 추가해 사용할 수가 이따. 이것이 프로토콜 지향 프로그래밍의 핵심 콘텐츠 중 하나이다. 프로토콜 + 엑스텐션 + 제네릭 조합으로 구현되어 있다.
protocol Popable: Container {
    mutating func pop() -> ItemType?
    mutating func push(_ item: ItemType)
}

extension Popable {
    mutating func pop() -> ItemType? {
        return items.removeLast()
    }
    mutating func push(_ item: ItemType){
        print("self: \(self)")
        self.append(item: item)
    }
}

//제네릭 타입 선언
struct Stack<Element>: Popable {
    var items: [Element] = [Element]()      //저장 프로퍼틴 Extension 안됨

}


var myIntStack : Stack<Int> = Stack<Int>()

myIntStack.push(10)

print(myIntStack.items)

myIntStack.push(20)
myIntStack.printSelf()

print(myIntStack[0])
myIntStack.pop()
print(myIntStack.count)
myIntStack.printSelf()
