import SwiftUI

/*
 프로토콜이란?
 특정 역할을 하기 위한 메소드, 프로퍼티, 기타 요구사항 등의 청사진

 
 프로토콜의 사용
 구조체, 클래스, 열거형은 프로토콜을 채택해서 특정 기능을 실행하기 위한 프로토콜의 요구사항을 실제로 구현할 수 있다.
 프로토콜은 정의를 하고 제시를 할 뿐 스스로 기능을 구현하지는 않는다. (조건만 정의)
 하나의 타입으로 사용되기 때문에 아래와 같이 타입 사용이 허용되는 모든 곳에 프로토콜을 사용할 수 있다.
 
 프로토콜을 채택한 타입은 프로토콜이 요구하는 프로퍼티의 이름과 타입만 맞도록 구현해 주면 됩니다. 다만 프로퍼티를 읽기 전용으로 할지 혹은 읽고 쓰기가 모두 가능하게 할지는 프로토콜이 정해야 한다.
 프로토콜이 익기 가능한 프로퍼티를 요구한다면 타입에 프로퍼티를 구현할 때 상수 저장 프로퍼티나 읽기 전용 프로퍼티를 포함해서 어떤 식으로든 프로퍼티를 구현할 수 있다.
 
 프로토콜의 프로퍼티 요구사항은 항상 var 키워드를 사용한 변수 프로퍼티로 정의한다. 
 
 
 함수, 메소드, 이니셜라이저의 파라미터 타입 혹은 리턴 타입
 - 상수, 변수, 프로퍼티의 타입
 - 배열, 딕셔너리의 원소타입
 */


//프로퍼티는 항상 var로 선언이 되어야 한다.

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
print(ncc1701.fullName)
// ncc1701.fullName is "USS Enterprise’






protocol Student {
    var height: Double { get set}
    var name: String { get }
    static var schoolNumber: Int { get set}
}

class Aiden: Student {
    var roundingHeight: Double = 0.0
    var height: Double {
        get {
            return roundingHeight
        }
        set {
            roundingHeight = newValue
        }
    }
    var name: String = "Aiden"
    static var schoolNumber: Int = 20112330
}

let aiden = Aiden()

print(aiden.height, aiden.name, Aiden.schoolNumber)

aiden.height = 150

print(aiden.height)

protocol Human {
    static func breathing()
    func sleeping(time: Int) -> Bool
    mutating func running()
}

struct Aidenn: Human {
    var heartRate = 100
    static func breathing() {
        print("숨을 쉽니다")
    }
    
    func sleeping(time: Int) -> Bool {
        if time >= 23 {
            return true
        } else {
            return false
        }
        
    }
    
    mutating func running() {
        heartRate += 20
    }
}

var aidenn = Aidenn()
print(Aidenn.breathing())
print(aidenn.sleeping(time: 23))
aidenn.running()
print(aidenn.heartRate)
