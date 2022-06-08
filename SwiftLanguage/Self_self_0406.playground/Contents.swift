import SwiftUI

//When you’re writing protocols and protocol extensions, there’s a difference between Self (capital S) and self (lowercase S). When used with a capital S, Self refers to the type that conform to the protocol, e.g. String or Int. When used with a lowercase S, self refers to the value inside that type, e.g. “hello” or 556.

//Self는 프로토콜을 준수하는 타입을 뜻한다. self는 그 타입의 값을 의미한다.
//여기서는 Self는 Int를 나타낸다. self는 해당 타입의 값을 나타낸다.
//BinaryInteger를 준수하는 Int type을 나타낸다.

extension BinaryInteger {
    func squareValue() -> Self {
        print(type(of: self))
        print(self)
        return self * self
    }
}

let value: Int = 5

let square = value.squareValue()


let array: Array<String> = Array(repeating: "", count: 5)


//인스턴스 self와 타입 self의 차이:
// .self 표현은 값 뒤에 써주면 그 값 자신을 타입 이름 뒤에 써주면 타입을 표현하는 값을 반환한다. "stringValue".self 는 값 자체를 String.self는 String 타입을 타나태는 값이다.

print([String].self)    // Array<String>
print(Int.self)         // Int, 타입을 나타낸다.
print(value.self)       // 5, 값 자체를 나타낸다.

//메타 타입: 타입의 타입을 뜻한다. 클래스 타입...

//Int 타입의 타입 : Int.Type 메타 타입도 타입이다. 타입 자리에 들어간다.
let intType: Int.Type = Int.self
print(intType)

let stringType: String.Type = String.self
print(stringType)   //String 타입을 리턴한다. 

protocol SomeProtocol { }
class SomeClass: SomeProtocol { }

let classType: SomeClass.Type = SomeClass.self
print(classType)  // SomeClass 타입을 리턴한다.

let protocolType: SomeProtocol.Protocol  = SomeProtocol.self
print(protocolType)
