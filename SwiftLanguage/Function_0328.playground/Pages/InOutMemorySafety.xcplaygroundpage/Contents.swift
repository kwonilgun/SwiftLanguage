//: [Previous](@previous)

import Foundation

//var step: Int = 1
//
//func increment(_ number: inout Int) {
//    number += step
//}

//increment(&step) 오류발생

func balance(_ x: inout Int, _ y: inout Int) {
    
    x = y
}

var playOne: Int = 40
var playTwo: Int = 30

balance(&playOne, &playTwo)
print(playOne)
