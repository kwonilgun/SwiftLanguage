//Protocol Composition
//It can be useful to require a type to conform to multiple protocols at the same time. You can combine multiple protocols into a single requirement with a protocol composition. Protocol compositions behave as if you defined a temporary local protocol that has the combined requirements of all protocols in the composition. Protocol compositions don’t define any new protocol types.’



import Foundation

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person: Named, Aged {
    var name: String
    var age: Int
}

class Car: Named {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Truck: Car, Aged {
    var age: Int
    
    init(name: String, age: Int) {
        self.age = age
        super.init(name: name)
    }
}



//하나의 매개 변수가 두개의 프로토콜을 요구한다.
func celebrateBirthday(to celebrator: Named & Aged) {
    print("Happy birthday \(celebrator.name)!! Now you are \(celebrator.age)")
}

let kwon: Person = Person(name: "kwon", age: 61)

celebrateBirthday(to: kwon)


class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)
// Prints "Hello, Seattle!



//프로토콜도 하나의 타입이다. kwon은 Person 구조체이다. Person은 Named와 Aged를 준수해야 한다.
if let casteInstance = kwon as? Named {
    print("\(casteInstance) is Named")
    print(casteInstance.name)
    //casteInstance.age: Value of type 'Named' has no member 'age'
    dump(casteInstance)
}

if let castInstance = kwon as? Aged {
    print("\(castInstance)")
    print(castInstance.age)
    dump(castInstance)
}
