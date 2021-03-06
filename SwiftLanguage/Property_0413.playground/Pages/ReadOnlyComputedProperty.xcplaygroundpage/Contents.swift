//: [Previous](@previous)

import Foundation

//โA computed property with a getter but no setter is known as a read-only computed property. A read-only computed property always returns a value, and can be accessed through dot syntax, but canโt be set to a different value.

//โYou can simplify the declaration of a read-only computed property by removing the get keyword and its braces:


struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0โ

var data : Int {
    get { return 100 }
}
print(data)

//๐โโ๏ธ๐โโ๏ธ์ฌ๊ธฐ์ get์ ์ ๊ฑฐํ ๊ฒ์ด๋ค. Read-Only ๊ณ์ฐ ํ๋กํผํฐ๋ก ๊ฐ์ฃผํ๋ค.
var integer: Int {
    return 50
}
print(integer)
