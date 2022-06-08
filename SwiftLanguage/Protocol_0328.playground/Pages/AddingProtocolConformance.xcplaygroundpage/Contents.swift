//: [Previous](@previous)

import Foundation

//You can extend an existing type to adopt and conform to a new protocol,’

//기존 타입의 소스 코드를 접근하지 않고, 새로운 프로토콜을 채택하고 준수함으로써 기존의 타입을 확대할 수 있다.
//Extension은 새로운 프로퍼티, 메소드, 스크립터를 기존 타입에 추가할 수 있다.

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

//Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand.’


protocol TextRepresentable {
    var textualDescription: String { get }
}

//Extension을 이용해서 프로토콜을 채택하고 기능을 구현한다. 프로토콜을 통해서 기존 클래스에 기능을 추가한다. 
//프로토콜 준수하고, 채택 즉 기능 구현을 한다.
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}


let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())

print(d12.textualDescription)
print(d12.roll())

//Declaring Protocol Adoption with an Extension’
//If a type already conforms to all of the requirements of a protocol, but hasn’t yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:


//Extension 으로 프로토콜 채택을 선언한다. 즉 추후에 Protocol adoptation을 한다.

struct Hamster {
    var name: String
    var textualDescription: String {
        return " A hamster named \(name)"
    }
}

//추후 adoptation 선언한다.
extension Hamster: TextRepresentable{}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(simonTheHamster.textualDescription)
print(somethingTextRepresentable.textualDescription)



// 프로토콜 자체의 extension
//Protocols can be extended to provide method, initializer, subscript, and computed property implementations to conforming types. This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.’


//프로토콜을 직접 구현을 했다.  randomBool이 직접구현이 되어서 인스턴스에서 이 메소드를 콜 할 수 있다. 
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        //print(random())
        return random() > 0.5
    }
}


let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And here's a random Boolean: \(generator.randomBool())")
// Prints "And here's a random Boolean: true’
