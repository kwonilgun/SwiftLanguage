//: [Previous](@previous)

import Foundation

//클래스와 구조체는 기존 연산자에 대한 자신만의 구현을 제공할 수 있습니다. 이를 기존 연산자의 중복 정의 (overloading) 라고 합니다.

//아래 예제는 ‘사용자 정의 구조체’ 에 대한 ‘산술 덧셈 연산자 (+)’ 를 구현하는 방법을 보여줍니다. ‘산술 덧셈 연산자’ 는 두 개의 대상을 연산하기 때문에 이항 연산자 (binary operator) 이며 이 두 대상 사이에 있기 때문에 중위 (infix)9 라고 말합니다.
//
//예제는 ‘2-차원 위치 벡터 (x, y)’ 를 위한 Vector2D 구조체를 정의하고, 이어서 Vector2D 구조체 인스턴스를 서로 더하기 위한 연산자 메소드 (operator method) 를 정의합니다:

struct Vector2D {
    var x = 0.0, y = 0.0
}

//이 구현에서, 입력 매개 변수는 + 연산자의 왼쪽과 오른쪽에 있는 Vector2D 인스턴스를 표현하기 위한 left 와 right 라는 이름을 붙입니다. 메소드는, 자신의 x 와 y 을 서로 더한 두 Vector2D 인스턴스에 있는 x 와 y 속성의 합으로 초기화하는, 새로운 Vector2D 인스턴스를 반환합니다.
extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.x + right.y)
    }
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector

print(combinedVector)


//Prefix and Postfix Operators (접두사 연산자와 접미사 연산자)

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
print(negative)


//Compound Assignment Operators (복합 할당 연산자)
//복합 할당 연산자 (compound assignment operators) 는 ‘할당 (=)’ 을 다른 연산과 조합합니다. 예를 들어, ‘더하기 할당 연산자 (+=)’ 는 ‘더하기’ 와 ‘할당’ 을 단일 연산으로 조합합니다. ‘복합 할당 연산자’ 의 ‘왼쪽 입력 매개 변수 타입’ 은, ‘연산자 메소드’ 안에서 매개 변수의 값을 직접 수정할 것이기 때문에, inout 으로 표시합니다.

//아래 예제는 Vector2D 인스턴스에 대한 ‘더하기 할당 연산자 메소드’ 를 구현합니다:

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D){
        left = left + right
    }
}

var original = Vector2D(x:1.0, y:2.0)
let vectorToAdd = Vector2D(x:3.0, y:4.0)

original += vectorToAdd
print(original)


//Equivalence Operators (같음 비교 연산자)

//기본적으로, 사용자 정의 클래스 및 구조체는, ‘같음 (equal to) 연산자 (==)’ 와 ‘같지 않음 (not equal to) 연산자 (!=)’ 라는, 같음 비교 연산자 euivalence operators) 구현을 가지지 않습니다. 대체로 == 연산자는 구현하며, == 연산자 결과를 반대로 만드는 != 연산자는 표준 라이브러리의 기본 구현을 사용합니다. == 연산자 구현에는 두 가지 방식이 있습니다: 자신이 직접 구현할 수도 있고, 아니면 ‘많은 타입’ 들에서, 구현을 만들어 통합하라고 스위프트에게 요청할 수 있습니다. 두 경우 모두, 표준 라이브러리의 Equatable 프로토콜에 대한 ‘준수성’ 을 추가합니다.
//
//== 연산자는 다른 ‘중위 연산자’ 를 구현하는 것과 똑같이 구현합니다:

extension Vector2D: Equatable {
    static func == (lhs: Vector2D, rhs: Vector2D) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y )
    }
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x:2.0, y:3.0)

if twoThree == anotherTwoThree {
    print("same")
}


//Custom Operators (사용자 정의 연산자)

//스위프트가 제공하는 ‘표준 연산자’ 에 더하여 자신만의 사용자 정의 연산자 (custom operators) 를 선언하고 구현할 수 있습니다. ‘사용자 정의 연산자’ 를 정의할 때 사용할 수 있는 문자들의 목록은, Operators (연산자) 를 참고하기 바랍니다.
//새로운 연산자는 operator 키워드를 사용하여 ‘전역 수준’ 에서 선언하며, prefix, infix, 또는 postfix 수정자로 표시합니다:12

prefix operator +++

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled

print(afterDoubling)
