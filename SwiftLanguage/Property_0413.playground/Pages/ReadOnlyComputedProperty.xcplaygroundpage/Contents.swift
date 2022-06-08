//: [Previous](@previous)

import Foundation

//‘A computed property with a getter but no setter is known as a read-only computed property. A read-only computed property always returns a value, and can be accessed through dot syntax, but can’t be set to a different value.

//‘You can simplify the declaration of a read-only computed property by removing the get keyword and its braces:


struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0’

var data : Int {
    get { return 100 }
}
print(data)

//💇‍♀️💇‍♀️여기서 get을 제거한 것이다. Read-Only 계산 프로퍼티로 간주한다.
var integer: Int {
    return 50
}
print(integer)
