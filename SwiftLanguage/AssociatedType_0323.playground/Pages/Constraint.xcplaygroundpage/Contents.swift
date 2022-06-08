
//연관된 타입의 제약조건에서 프로토콜 사용 (Using a Protocol in Its Associated Type’s Constraints)
//여기서 중요한 것은 프로토콜 B의 Element.Example는 protocol A의 Example과 동일하다는 것이다. protocol B의 at는 영향을 받고


//‘A protocol can appear as part of its own requirements. For example, here’s a protocol that refines the Container protocol, adding the requirement of a suffix(_:) method. The suffix(_:) method returns a given number of elements from the end of the container, storing them in an instance of the Suffix type.’


import Foundation


protocol A {
    associatedtype Example: Equatable
    var nameA: Example { get }
}

protocol B : A {
    associatedtype Element : B where Element.Example == Example
    
    // 이것은 위의 조건을 부합하는 Element를 리턴한다. 즉 Element에는 여러가지 타입이 올 수 있다는 것을 나타낸다.
    //하지만 B protocol을 준수하고 B는 다시 A protocol을 준수한다. 그러면 결국 Element는 A의 associatedtype을 준수한다.
    func someValue() -> Element
}

//var b: B?
struct someThingA: A {
    var nameA: Int { return 10}
    //var nameB: Element{ return 100}
}

struct someThingS: A {
    var nameA: String { return "Kwon"}
}

struct someThingD: A {
    var nameA: Int { return 10}
    //var nameB: Element{ return 100}
}

struct someThingE: B {
    var nameA: Int { return 10000}
    func someValue() -> someThingE {
        return someThingE()
    }
}
var someE = someThingE()
let someEE = someE.someValue().nameA
print(someEE)

struct someThingF: B {
    var nameA: String { return "Hello"}
    func someValue() -> someThingF {
        return someThingF()
    }
}

var someF = someThingF()
let someFF = someF.someValue().nameA
print(someFF)


extension someThingA : B {
    func someValue() -> someThingA {
        return someThingA()
    }
}
var someA = someThingA()
var someDataA = someA.someValue()
print(someA.nameA)   // 프린터 10

extension someThingS: B {
    func someValue() -> someThingS {
        return someThingS()
    }
}

var someValue = someThingS()
var someData = someValue.someValue()

print(someData.nameA)   //프린터 "Kwon"

extension someThingD: B {
    func someValue() -> someThingD {
        return someThingD()
    }
}

var someD = someThingD()
var someDataD = someD.someValue()
print(someDataD)
