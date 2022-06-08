//: [Previous](@previous)

import Foundation

//Initializer Inheritance and Overriding : 이니셜라이저 상속과 덮어쓰기

//Unlike subclasses in Objective-C, Swift subclasses don’t inherit their superclass initializers by default. Swift’s approach prevents a situation in which a simple initializer from a superclass is inherited by a more specialized subclass and is used to create a new instance of the subclass that isn’t fully or correctly initialized.

//‘When you write a subclass initializer that matches a superclass designated initializer, you are effectively providing an override of that designated initializer. Therefore, you must write the override modifier before the subclass’s initializer definition. This is true even if you are overriding an automatically provided default initializer, as described in Default Initializers.’

//자동적으로 제공되는 default initializer를 제공하더라도 적용이 된다.
//override를 붙여야 한다.

//‘Conversely, if you write a subclass initializer that matches a superclass convenience initializer, that superclass convenience initializer can never be called directly by your subclass, as per the rules described above in Initializer Delegation for Class Types. Therefore, your subclass is not (strictly speaking) providing an override of the superclass initializer. As a result, you don’t write the override modifier when providing a matching implementation of a superclass convenience initializer.’

//슈퍼클래스 편의 이니셜라이저의 매칭 구현을 제공할 때 override modifier를 구현할 필요가 없다.

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")


//여기서는 numberOfWheels를 먼저 초기화하고 class Bicycle에서 값을 변경한다.
class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bike = Bicycle()
print("Bike: \(bike.description)")


//This example defines another subclass of Vehicle, called Hoverboard. In its initializer, the Hoverboard class sets only its color property. Instead of making an explicit call to super.init(), this initializer relies on an implicit call to its superclass’s initializer to complete the process.

//슈퍼 클래스 초기화를 암묵적으로 콜에 의존한다. 서브 클래스 자체 값을 먼저 세팅을 하고 슈퍼클래스 초기화를 암묵적으로 부른다.


class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() implicitly called here
        //암묵적으로 불러진다.
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}

let hoverboard = Hoverboard(color: "silver")
hoverboard.numberOfWheels = 3
print("Hoverboard: \(hoverboard.description)")
