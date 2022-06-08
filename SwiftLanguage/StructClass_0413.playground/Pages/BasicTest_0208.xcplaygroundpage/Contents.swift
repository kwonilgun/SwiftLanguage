//: [Previous](@previous)

import SwiftUI

//구조체에서 생성된 이니셜라이저의 매개변수는 구조체의 프로퍼티 이름으로 자동 지정된다.
//

struct BasicInformation {
    var name: String
    var age: Int
}

var kwonInfo: BasicInformation = BasicInformation(name: "권일근", age: 61)

dump(kwonInfo)


//클래스를 생성하고 초기화할 때는 기본적으로 이니셜라이저를 사용한다.
//구조체와는 달리 인스턴스는 참조타입임으로 클래스의 인스턴스를 상수 let으로 선언해도 내부 프로퍼티 값을
//변경할 수 있다.

class Person {
    var height: Double
    var weight: Double
    
    init(height: Double, weight: Double){
        self.height = height
        self.weight = weight
    }
    deinit{
        print("클래스 인스턴스 소멸")
    }
}


var person: Person? = Person(height: 180, weight: 70)
dump(person)

person?.weight = 75
person?.height = 170

dump(person)
person = nil

//스위프트의 기본 타입은 모두 구조체이다.
//스위프트의 기본 타입(Bool, Int, Array, Dictionary, Set)등은 모두 구조체 타입이다.
//기본 데이타 타입은 모두 값 타입이다. 전달인자를 통해서 값이 전달되면 모두 값이 복사되어
//전달될 뿐, 함수 내부에서 아무리 전달된 값을 변경해도 기존의 변수나 상수에 영향을 주지 못한다. 
