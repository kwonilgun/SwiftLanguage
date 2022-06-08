//: [Previous](@previous)

import Foundation

//Assigning to self Within a Mutating Method
//Mutating methods can assign an entirely new instance to the implicit self property. The Point example shown above could have been written in the following way instead:’

//Mutating 메소드 내에서 self에 값 지정 가능하다. 자신을 updating 하는 것이다.

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}


//자기 자신을 update 한다.
var point = Point()
point.moveBy(x: 3, y: 3)

print(point)

//이것도 자신을 update 한다.

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off

print(ovenLight)

