//: [Previous](@previous)

import Foundation
//‘Modifying Value Types from Within Instance Methods
//‘Structures and enumerations are value types. By default, the properties of a value type can’t be modified from within its instance methods.

//However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to mutating behavior for that method. The method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit self property, and this new instance will replace the existing one when the method ends.

//구조와 열거형은 값 유형이다. 기본적으로, 값 유형의 속성은 인스턴스 메소드 내에서 수정할 수 없습니다.

//그러나, 특정 방법 내에서 구조나 열거형의 속성을 수정해야 하는 경우, 해당 메소드에 대한 돌연변이 동작을 선택할 수 있습니다. 그런 다음 메서드는 메소드 내에서 속성을 돌연변이(즉, 변경)할 수 있으며, 메서드가 끝나면 변경 사항은 원래 구조에 다시 기록됩니다. 이 방법은 또한 암시적 self 속성에 완전히 새로운 인스턴스를 할당할 수 있으며, 이 새로운 인스턴스는 메소드가 끝날 때 기존 인스턴스를 대체할 것이다.

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// Prints "The point is now at (3.0, 4.0)’



//‘Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. You use the self property to refer to the current instance within its own instance methods.

//함수내에서 사용하는 경우 현재의 인스턴스를 self가 참조를 한다.


//‘Mutating methods can assign an entirely new instance to the implicit self property. The Point example shown above could have been written in the following way instead:

struct PointS {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = PointS(x: x + deltaX, y: y + deltaY)
    }
}

var point = PointS()

//자기 자신을 변경한다.
point.moveBy(x: 10.0, y: 10.0)

print(point)

point.moveBy(x:20.0, y:30.0)
print(point)


//‘Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration:
// 자기 자신을 변경할 수 있다. 자기 자신이 변경이 된다.

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
print(ovenLight)
// ovenLight is now equal to .high
ovenLight.next()
print(ovenLight)
// ovenLight is now equal to .off
