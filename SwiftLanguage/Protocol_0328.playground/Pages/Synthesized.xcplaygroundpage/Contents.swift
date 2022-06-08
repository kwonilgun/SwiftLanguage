
import Foundation


//The Equatable protocol allows Swift to compare one instance of a type against another. When we say 5 == 5, Swift understands what that means because Int conforms to Equatable, which means it implements a function describing what == means for two instances of Int.
//
// 5==5 는 스위프트는 Int 가 Equatable 프로토콜을 준수하기 때문에 == 비교 구문을 자동으로 생성을 해 준다. 프로토콜로 선언만해 주면 컴파일러가 알아서 비교구문을 만들어준다. 이것을 synthesized implementation이라고 한다.

//Implementing Equatable in our own value types allows them to work like Swift’s strings, arrays, numbers, and more, and it’s usually a good idea to make your structs conform to Equatable just so they fit the concept of value types better.
//
//However, implementing Equatable can be annoying. Consider this code:





//struct Person: Equatable {
//    var firstName: String
//    var lastName: String
//    var age: Int
//    var city: String
//
//    static func ==(lhs: Person, rhs: Person) -> Bool {
//        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.age == rhs.age && lhs.city == rhs.city
//    }
//}


//Fortunately, Swift 4.1 can synthesize conformance for Equatable – it can generate an == method automatically, which will compare all properties in one value with all properties in another, just like above. So, all you have to do now is add Equatable as a protocol for your type, and Swift will do the rest.


//Person: Equatable 로 선언이 되었기 때문에, == 이 자동으로 생성이 된다. 이것을 Synthesized Implementation 이라고 한다. 자동으로 비교 == 구문이 만들어진다.

//Equatable은 같은 지를 물어보는 프로토콜이고, 굳이 == 함수를 구현하지 않아도 비교가 되게 해 준다.

//💇‍♀️ -> Equatable이 있으므로 자동으로 == 코드가 생성이 된다. 굳이 구현할 필요가 없다.
struct Person: Equatable {
    var firstName: String
    var lastName: String
    var age: Int
    var city: String
}
let person = Person(firstName: "Kwon", lastName:"ILGUN", age: 62, city: "Seoul")

let personA = Person(firstName: "Kwon", lastName:"ILGUN", age: 62, city: "Seoul")

if(person == personA) {
    print("같은 구조체이다.")
}


struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}
// Prints "These two vectors are also equivalent.’


//‘Swift provides a synthesized implementation of Comparable for enumerations that don’t have a raw value. If the enumeration has associated types, they must all conform to the Comparable protocol. To receive a synthesized implementation of <, declare conformance to Comparable in the file that contains the original enumeration declaration, without implementing a < operator yourself. The Comparable protocol’s default implementation of <=, >, and >= provides the remaining comparison operators.

//Comparable는 비교 가능하게 해 주는 프로토콜이다. 굳이 <, > 구현하지 않아도 된다.

enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}
var levels = [SkillLevel.intermediate, SkillLevel.beginner,
              SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
for level in levels.sorted() {
    print(level)
}
// Prints "beginner"
// Prints "intermediate"
// Prints "expert(stars: 3)"
// Prints "expert(stars: 5)"

