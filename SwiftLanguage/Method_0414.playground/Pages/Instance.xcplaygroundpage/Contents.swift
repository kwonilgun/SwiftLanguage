//: [Previous](@previous)

import Foundation

//‘Methods are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures, and enumerations can also define type methods, which are associated with the type itself. Type methods are similar to class methods in Objective-C.’

// 메소드는 어떤 특정 타입과 관련된 함수
//‘Instance methods are functions that belong to instances of a particular class, structure, or enumeration’

//인스턴스 메소드는 특정한 타입의 인스턴스에 속하는 함수이다.

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.increment()
print(counter.count)
