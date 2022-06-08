//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//‘Structures and enumerations are value types. By default, the properties of a value type can’t be modified from within its instance methods.’
//구조체, 이넘은 value type이다. 기본적으로 인스턴스 메소드 내에서는 프로퍼티 값을 변경할 수 없다.

//변경을 하기 위해서는 mutating 키워드를 사용해야 한다.

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
// Prints "The point is now at (3.0, 4.0)

//💇‍♀️💇‍♀️이것을 에러가 발생한다. -> 상수로 선언이 되었기 때문이다. 
let fixedPoint = Point(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)
// this will report an error

