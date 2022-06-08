import Foundation

//A class can inherit methods, properties, and other characteristics from another class. When one class inherits from another, the inheriting class is known as a subclass, and the class it inherits from is known as its superclass. Inheritance is a fundamental behavior that differentiates classes from other types in Swift.’

//클래스는 메소드 프로퍼티 다른 특성을 다른 클래스로부터 상속을 받는다.
//다른 타입과 구별이 된다. 서브클래스 / 슈퍼 클래스 로 구분

//Classes in Swift can call and access methods, properties, and subscripts belonging to their superclass and can provide their own overriding versions of those methods, properties, and subscripts to refine or modify their behavior. Swift helps to ensure your overrides are correct by checking that the override definition has a matching superclass definition.

//클래스는 오버라이드가 가능한다.

//베이스클래스
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

let someVehicle = Vehicle()

print(someVehicle.description)
//서브 클래싱

class Bicycle: Vehicle {
    var hasBasket = false
}

let bicyle = Bicycle()
bicyle.hasBasket = true
bicyle.currentSpeed = 15.0

print(bicyle.description)

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0

//오버라이딩
//‘A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.
//To override a characteristic that would otherwise be inherited, you prefix your overriding definition with the override keyword. Doing so clarifies that you intend to provide an override and haven’t provided a matching definition by mistake. Overriding by accident can cause unexpected behavior, and any overrides without the override keyword are diagnosed as an error when your code is compiled.’

class Train: Vehicle {
    override func makeNoise() {
        print("추추")
    }
}

var train = Train()
train.makeNoise()

//‘Preventing Overrides
//You can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the final modifier before the method, property, or subscript’s introducer keyword (such as final var, final func, final class func, and final subscript).’

