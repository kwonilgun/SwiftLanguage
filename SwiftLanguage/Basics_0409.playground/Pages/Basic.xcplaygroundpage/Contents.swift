import SwiftUI

//‘Like C, Swift uses variables to store and refer to values by an identifying name. Swift also makes extensive use of variables whose values can’t be changed.’

//Swift는 변수에 값을 저장하고 이름을 통해서 값을 참조한다. 상수도 광범위하게 이용을 한다.
//tuple도 지원을 한다. 값을 그룹핑한다.
//optional type도 지원을 한다. 값의 부재를 지원하다. nil 과 같다.
//스위프트는 타입 안전 언어이다. type-safe 언어이다. 타입에 대해서 명확하다.
//Type safety helps you catch and fix errors as early as possible in the development process.’
//타입 안전은 개발 단계에서 에러를 캐치하고 수정을 한다.

//상수와 변수

let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

//Type Annotations
var welcomeMessage: String
welcomeMessage = "Hello"

var red, green, blue: Double

//‘Naming Constants and Variables’
let pi = 3.14159

//Printing Constants and Variables
print("hello", terminator: ",")
print("world")


//Semicolons
//‘Unlike many other languages, Swift doesn’t require you to write a semicolon (;) after each statement in your code, although you can do so if you wish. However, semicolons are required if you want to write multiple separate statements on a single line:

//single line에 멀티 statement를 작성하기를 원하는 경우 세미콜론을 적용
let cat = "🐱"; print(cat)
// Prints "🐱’


//Integers
//Swift provides signed and unsigned integers in 8, 16, 32 and 64bit forms

let minValue = UInt8.min    //0
let maxValue = UInt8.max    //255


//On a 64-bit platform, Int is the same size as Int64
print("Integer Max :\(Int.max)")

//UInt
print("UInt Max:\(UInt.max)")
