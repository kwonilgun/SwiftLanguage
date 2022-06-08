//: [Previous](@previous)

import Foundation


let decimalInteger = 17
let binaryInteger = 0b10001
let octaInteger = 0o21
let hexadecimalInteger = 0x11


let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0

let oneMillion = 1_000_000
print(oneMillion)

let justOverOneMillion = 1_000_000_000.000_000_1
print(justOverOneMillion)

//let cannotBeNegative: UInt8 = -1
// UInt8 can't store negative numbers, and so this will report an error
//let tooBig: Int8 = Int8.max + 1
// Int8 can't store a number larger than its maximum value,
// and so this will also report an error’

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
//let twoThousandAndOne = twoThousand + one : Error

let twoThousandAndOne = twoThousand + UInt16(one)
//SomeType(ofInitialValue) is the default way to call the initializer of a Swift type and pass in an initial value. Behind the scenes, UInt16 has an initializer that accepts a UInt8 value, and so this initializer is used to make a new UInt16 from an existing UInt8.
//
print(UInt16(one))


//좌표와 원의 관계


struct Point {
    var x: Int = 0
    var y: Int = 0
    
}

class Circle {
    var point: Point?
    var name : String
    
    init(name: String) {
        self.name = name
    }
    
    var center: Point {
        get {
            Point(x: (self.point?.x ?? 0) / 2  , y: (self.point?.y ?? 0) / 2 )
        }
        set {
            point?.x = newValue.x * 2
            point?.y = newValue.y * 2
        }
    }
}


let circle = Circle(name: "Kwon")
circle.point = Point(x: 4, y: 6)
circle.center = Point(x: 10, y: 10)
print(circle.point ?? "원점")
print(circle.center)
