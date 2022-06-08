//: [Previous](@previous)

import Foundation

//Raw Values
//The barcode example in Associated Values shows how cases of an enumeration can declare that they store associated values of different types. As an alternative to associated values, enumeration cases can come prepopulated with default values (called raw values), which are all of the same type.


enum ASCIIControlCharacter: Character {
    case tab = "t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

let tabKey = ASCIIControlCharacter.tab
print(tabKey.rawValue)


//Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is always the same. Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, and can be different each time you do so.


//Implicitly Assigned Raw Values : 암묵적인 원시값 지정
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

let mercury = Planet.mercury
print(mercury.rawValue)

enum CompassPoint: String {
    case north, south, east, west
}


//원시값을 지정하지 않는 경우 암묵적으로 "north" 이다.
let compass = CompassPoint.north
print(compass.rawValue)


//Intializing from a Raw Value
//‘If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called rawValue) and returns either an enumeration case or nil. You can use this initializer to try to create a new instance of the enumeration.

let possiblePlanet = Planet(rawValue: 7)
print(possiblePlanet ?? "nil")
