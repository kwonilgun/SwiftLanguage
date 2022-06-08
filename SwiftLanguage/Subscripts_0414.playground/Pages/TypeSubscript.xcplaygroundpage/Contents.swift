//: [Previous](@previous)

import Foundation

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn
    
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}

let mars = Planet[4]

print(mars)

