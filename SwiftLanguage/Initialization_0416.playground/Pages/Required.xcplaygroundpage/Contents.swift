//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//Required Initializers
//Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:
//모든 서브 클래스에서 구현을 해야하는 경우   required 를 쓴다.


class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}

//You must also write the required modifier before every subclass implementation of a required initializer, to indicate that the initializer requirement applies to further subclasses in the chain. You don’t write the override modifier when overriding a required designated initializer:
//override를 사용하지 않는다. 
class SomeSubclass: SomeClass {
    required init() {
        // subclass implementation of the required initializer goes here
    }
}
