//: [Previous](@previous)


//연산 프로퍼티 예제이다. 즉 실제로 값을 저장하는 것이 아니다. 간접적으로 다른 프로퍼티와 값을 꺼내오거나 세팅하는 역할을 한다. 여기서 center는 원점과 사이즈를 이용해서 센터 값을 구하면 되기 때문에 center를 연산 프로퍼티로 지정을 하면 되는 것이다. 

import Foundation

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
print(square)
let initialSquareCenter = square.center

print("before:\(square.center)")        //getter

square.center = Point(x: 15.0, y: 15.0)   //setter

print("after:\(square.center)")
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
print(square.origin)
// Prints "square.origin is now at (10.0, 10.0)’

square.center = Point(x: 100, y: 100) //Point는 origin 이다.
print(square.size)
print(square.origin)
print(square.center)


