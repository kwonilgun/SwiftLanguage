
//제목 -> Checking for Protocol Conformance
//You can use the is and as operators described in Type Casting to check for protocol conformance, and to cast to a specific protocol. Checking for and casting to a protocol follows exactly the same syntax as checking for and casting to a type:’


//is 는 프로토콜 준수를 체크한다. 해당되면 true 리턴한다.
//as? 는 다운캐스터를 수행하고 프로토콜 타입의 optional value를 리턴한다.

//The is operator returns true if an instance conforms to a protocol and returns false if it doesn’t.

//The as? version of the downcast operator returns an optional value of the protocol’s type, and this value is nil if the instance doesn’t conform to that protocol.

//The as! version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast doesn’t succeed.’

import Foundation

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
//여기 객체들은
//‘The objects array can now be iterated, and each object in the array can be checked to see if it conforms to the HasArea protocol:

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}


//Whenever an object in the array conforms to the HasArea protocol, the optional value returned by the as? operator is unwrapped with optional binding into a constant called objectWithArea. The objectWithArea constant is known to be of type HasArea, and so its area property can be accessed and printed in a type-safe way.

//객체가 HasArea 프로토콜은 준수하면 as?에 의해서 리턴된 옵션 값은 옵셔널 바인딩에 의해서 upwrapped 되고 상수인 objectWithArea에 저장이 된다. 이것이 downcastin 되는 것이다. 
