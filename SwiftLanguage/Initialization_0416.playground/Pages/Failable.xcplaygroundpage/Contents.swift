//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//‘Failable Initializers : 초기화 실패의 경우

//It’s sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.
//초기화 실패에 대해서 클래스, 구조체, 이넘을 정의하는 것이 유효하다.

//To cope with initialization conditions that can fail, define one or more failable initializers as part of a class, structure, or enumeration definition. You write a failable initializer by placing a question mark after the init keyword (init?).

//실패 조건을 주기 위해서 init? 키워드를 사용한다.

//‘Failable initializers are implemented for numeric type conversions. To ensure conversion between numeric types maintains the value exactly, use the init(exactly:) initializer. If the type conversion can’t maintain the value, the initializer fails.

//

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let animal = Animal(species: "")
//animal은 옵셔널이 된다.
print(animal ?? "nil")

//‘Failable Initializers for Enumerations
//You can use a failable initializer to select an appropriate enumeration case based on one or more parameters. The initializer can then fail if the provided parameters don’t match an appropriate enumeration case.

enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
