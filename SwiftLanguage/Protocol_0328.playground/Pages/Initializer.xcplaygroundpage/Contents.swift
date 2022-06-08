//: [Previous](@previous)

import Foundation

//Protocols can require specific initializers to be implemented by conforming types. You write these initializers as part of the protocol’s definition in exactly the same way as for normal initializers, but without curly braces or an initializer body:’
//일반적인 이니셜라이저 처럼 프로토콜 정의의 일부로써 작성을 한다. {} 는 없이


//protocol SomeProtocol {
//  init(someParameter: Int)
//}


//‘Class Implementations of Protocol Initializer Requirements
//You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier:
protocol SomeProtocol {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}
