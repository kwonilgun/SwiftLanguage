//: [Previous](@previous)

import Foundation

//protocol ZeddProtocol {
//    var name: String {get}
//}

//이제 이 ZeddProtocol을 채택하는 모든 타입은 반드시 name을 정의해주어야 하죠.
//get만을 요구하니 어떠한 종류의 프로퍼티든 상관없이 이 요구조건을 만족할 수 있겠네요.
//원한다면 set도 될 수 있구요!!!
//암튼 잠깐 복습...
//
//근데..만약 음..name이 물론 String이겠지만!!! 뭐 Int가 될 수 있다면?????
//String말고 다른 타입이 될 수 있는 여지가 있다면!?!??!?!?!?!
//이럴 때!!!!! 바로 Associated Type을 사용하면 됩니다.


protocol ZedProtocol {
    associatedtype myType
    var name: myType { get }
}

struct Zed: ZedProtocol {
    var name: String {
        return "Kwon"
    }
}
var zed = Zed()
print(zed.name)

struct ZedInt: ZedProtocol {
    var name: Int {
        return 1009
    }
}

var zedInt = ZedInt()
print(zedInt.name)

//protocol ZeddProtocol{
//    associatedtype MyType: Equatable
//    var name: MyType { get }
//}
//Equatable이 뭔지 모르신다면 <Equatable>글을 참고해주세요.
//ㅇㅇ야 name이 무슨타입인진 모르겠는데 근데 Equatable을 준수하는 타입이어야해
//라고 제약사항을 걸어주는 것이죠.
//<Equatable>글에도 나오지만 Swift의 기본데이터타입은 Equatable을 만족시키지만..
//
class B{ }
//
//제가 방금 만든 A라는 클래스는, 즉 A라는 타입은 Equatable을 준수하지 않죠.
//그렇다면..?

struct Tom: ZedProtocol {
    
    var name: B {
        return B()
    }
}

//Equatable의 제약 조건을 둔 경우
protocol ZedProtocolEquatable {
    associatedtype MyType: Equatable
    var name: MyType { get }
}

class A: Equatable {
    var val : Int
    
    init(val: Int) {
        self.val = val
    }
    
    static func == (lhs: A, rhs: A) -> Bool {
        return lhs.val == rhs.val
    }
}

struct Marry: ZedProtocolEquatable {
    
    var data: Int
    var name: A {
        return A(val: self.data)
    }
    
}
//
//이렇게한다면...????????네..error를 내게 됩니다.
//무슨 에러일까요. Type 'Elsa' does not conform to protocol 'ZeddProtocol'
//ZeddProtocol의 Associated Type인 MyType은 Equatable을 준수하는 타입이어야하는데..그걸 준수하지 않았으니 이런 에러를 내게 됩니다.
//
//Associated Type이 프로토콜에서 나오는 것 같지만 사실, <Generic>에서 나오는 개념 중 하나랍니다.
//Associated Type은 <Generic> 서 Placeholder같은 역할을 한답니다 :) 타입의 견본을 주는거죠. 진짜 타입을 주는게 아니라요!! 사용할 실제 타입은 프로토콜이 적용될때가지 지정되지 않으니 유용하게 쓸 수 있습니다.


struct Elsa : ZedProtocolEquatable {
    var data: Int
    var name: A {
        return A(val: self.data)
    }
}


let data_1 = A(val: 5)
let data_2 = A(val: 7)

if data_1 != data_2  {
    print("데이타가 같지 않다")
}

let val_1 = Elsa(data: 3)
let val_2 = Elsa(data: 3)
print(val_1.name)
print(val_2.name)

if val_1.name == val_2.name {
    print(" 같다.")
}
else {
    print("틀림")
}
