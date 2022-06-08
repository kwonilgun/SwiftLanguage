//: [Previous](@previous)

import Foundation

enum CompassPoint: String {
    case north, south, east, west
}


//‘In the example above, CompassPoint.south has an implicit raw value of "south", and so on.
print(CompassPoint.south.rawValue)  //south : 암묵적으로 "south" 이다.

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

if let possiblePlanet = Planet(rawValue: 7) {
    print(possiblePlanet)
}
// possiblePlanet is of type Planet? and equals Planet.uranus’

//Not all possible Int values will find a matching planet, however. Because of this, the raw value initializer always returns an optional enumeration case. In the example above, possiblePlanet is of type Planet?, or “optional Planet.
