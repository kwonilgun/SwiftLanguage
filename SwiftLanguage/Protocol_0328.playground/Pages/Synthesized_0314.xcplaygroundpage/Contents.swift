

import Foundation

//Title-> Adopting a Protocol Using a Synthesized Implementation

//‘Swift can automatically provide the protocol conformance for Equatable, Hashable, and Comparable in many simple cases. Using this synthesized implementation means you don’t have to write repetitive boilerplate code to implement the protocol requirements yourself.
//자동적으로 Equatable, Hashable, Comparable에 대한 프로토콜 준수를 제공한다.

//‘Swift provides a synthesized implementation of Equatable for the following kinds of custom types:

//Structures that have only stored properties that conform to the Equatable protocol
//Enumerations that have only associated types that conform to the Equatable protocol
//Enumerations that have no associated types’

//‘To receive a synthesized implementation of ==, declare conformance to Equatable in the file that contains the original declaration, without implementing an == operator yourself. The Equatable protocol provides a default implementation of !=.

//이미 구현된 합성 구현을 받기 위해서 Equatable을 준수를 선언한다. Equatable 프로토콜은 구현할 필요없이 제공이 된다. 이미 합성된 구현을 제공받았기 때문이다.

//스위프트는 다음과 같은 종류의 Custom type에 대해  `Equatable` 통합된 구현을 제공합니다:
//저장 속성만을 가지면서, 그 속성들이 모두 `Equatable`을 따르는(conform) 구조체
//`Equatable`을 따르는 associated type 만을 가지는 열거형
//associated type이 없는 열거형
//`==`  연산자에 대한 통합된 구현을 받으려면, 원본 타입 선언에서 `Equatable` 채택을 선언해야 합니다.
//
//그리고 직접 `==`  연산자를 구현하지 않아도 됩니다.
//
//`Equatable` 프로토콜은 `!=` 연산자의 구현도 제공합니다.

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}

let threeFourFive = Vector3D(x: 3.0, y: 4.0, z: 5.0)
if twoThreeFour != threeFourFive {
    print("These two vectors are also different")
}

//swift provides a synthesized implementation of Hashable for the following kinds of custom types:

//Structures that have only stored properties that conform to the Hashable protocol
//
//Enumerations that have only associated types that conform to the Hashable protocol
//
//Enumerations that have no associated types’

//Swift provides a synthesized implementation of Comparable for enumerations that don’t have a raw value. If the enumeration has associated types, they must all conform to the Comparable protocol. ’


enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}
var levels = [SkillLevel.intermediate, SkillLevel.beginner,
              SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
//소팅이 가능한 이유는 Comparable protocol을 준수하기 때문이다. 이미 합성된 구현을  제공받았기 때문이다.

for level in levels.sorted() {
    print(level)
}


