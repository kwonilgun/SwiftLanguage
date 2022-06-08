//: [Previous](@previous)

import Foundation

//강한순환참조

//인스턴스끼리 서로가 서로를 강한 참조할 때를 대표적인 예로 들어 수 있다. 강한 참조 순환이라고 한다. 인스턴스끼리 서로가 서로를 강한 참조할 때를 대표적인 예로 들 수 있다. 이를 강한 참조 순환이라고 부른다.

class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var room: Room?
    
    deinit{
        print("\(name) is being deinitialzed")
    }
}

class Room {
    let number: String
    init(number: String) {
        self.number = number
    }
    
    var host: Person?
    deinit {
        print("\(number) is being deinitialzed")
    }
}

var kwon: Person? = Person(name: "Kwon")   //Person 인스턴스 참조 횟수: 1
var number: Room? = Room(number: "123")   //Room 인스턴스 참조 횟수: 1

number?.host = kwon       //Person 인스턴스의 참조 횟수 : 2
kwon?.room = number         //Room 인스턴스의 참조 횟수 : 2

//프로퍼티 또는 변수에 nil을 할당하면 참조횟수가 감소한다는 규칙을 생각해 보면 매번 찾아서 처리를 해 주어야 한다. 만약 실수로 깜박해서 코드를 빼 먹으면 아니면 해제할 프로퍼티가 너무 많거나 귀찮다면 종 더 깔끔하고 멋진 해결 책이 없을 까? 이것이 약한 참조이다. 


kwon?.room = nil           // 프로퍼티에 nil
number?.host = nil


//여기서 메모리가 해제가 된다. 이것이 strong refercence cycle가 해제된다.
kwon = nil                  //변수에 nil 을 할당한다.
number = nil


