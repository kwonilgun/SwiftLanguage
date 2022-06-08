//: [Previous](@previous)

import Foundation

//프로퍼티 랩퍼의 신텍스는 프로퍼티 래퍼에 대한 합성 설탕이다.

//Because property wrapper syntax is just syntactic sugar for a property with a getter and a setter, accessing height and width behaves the same as accessing any other property. For example, the code in resize(to:) accesses height and width using their property wrapper. If you call resize(to: .large), the switch case for .large sets the rectangle’s height and width to 100. The wrapper prevents the value of those properties from being larger than 12, and it sets the projected value to true, to record the fact that it adjusted their values.

//💇‍♀️글로벌 변수와 로컬 변수에 computed variables과 observers를 정의할 수 있다.
//you can also define computed variables and define observers for stored variables, in either a global or local scope. Computed variables calculate their value, rather than storing it, and they’re written in the same way as computed properties.’

//💇‍♀️하지만, 프로퍼티 래퍼는 로컬 저장 변수에만 정의할 수 있다. 글로벌 변수와 계산 변수에는 적용이 안된다.

//You can apply a property wrapper to a local stored variable, but not to a global variable or a computed variable. For example, in the code below, myNumber uses SmallNumber as a property wrapper.’

@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool

    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }

    init() {
        self.number = 0
        self.projectedValue = false
    }
}

//로컬 저장 변수에만 프로퍼티 래퍼를 적용할 수 있다.
func someFunction() {
    @SmallNumber var myNumber: Int

    myNumber = 10
    // now myNumber is 10

    myNumber = 24
    // now myNumber is 12
    print(myNumber)
}

someFunction()

//이것은 computed variable 이다. 글로벌 변수에
var globalComputed: Int { return 100 }
print(globalComputed)


//옵저버블도 global과 로컬 변수에 적용이 가능하다.
var globalObserver: Int = 0 {
    willSet {
        print(newValue)         //newValue = 100
    }
    didSet {
        print(oldValue)         //oldValue = 0
    }
}

globalObserver = 100
