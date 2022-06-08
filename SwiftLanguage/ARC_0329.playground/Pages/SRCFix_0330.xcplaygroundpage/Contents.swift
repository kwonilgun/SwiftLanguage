//: [Previous](@previous)

import Foundation

//약한 참조는 상수에서 쓰일 수 없다. 만약 자신이 참조하던 인스턴스가 메모리에서 해제된다면 nil이 할당하기 때문이다. 약한 참조는 항상 옵셔널이 되어한다. nil이 할당이 될 수 있기 때문이다. 


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
    weak var host: Person?          //weak 적용해서 문제해결함
    deinit {
        print("\(number) is being deinitialzed")
    }
}

var kwon: Person? = Person(name: "Kwon")   //Person 인스턴스 참조 횟수: 1
var number: Room? = Room(number: "123")   //Room 인스턴스 참조 횟수: 1


number?.host = kwon // 약한 참조이기 때문에, Person 인스턴스 참조 횟수 :1
kwon?.room = number // Room 인스턴스 참조횟수 : 2

kwon = nil // Person 인스턴스 : 0, Room 인스턴스 자동으로 1 감소해서: 1
number = nil

// 이렇게 하면 간단하게, 메모리를 deinit 할 수 있다.

//💇‍♀️ 💇‍♀️순차적으로 메모리가 해제가 된다. 우선 kwon=nil을 하면 Person의 정보를 인스턴스의 레퍼런스 카운터가 0이 되면서 여기에 할당된 것들은 삭제가 된다. 이렇게 되면 room에 할당된 것도 자연스럽게 사라진다. 그럼으로 자동으로 Room 인스턴스가 감소를 하게 된다. 통쨰로 사라지면서 Room 참조횟수가 자연스럽게 1 감소하게 된다. 그리고 number를 nil로 하게 되면 모두 메모리에서 해제가 된다. 
