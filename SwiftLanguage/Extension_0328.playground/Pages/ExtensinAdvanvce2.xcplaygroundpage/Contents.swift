//코드 26-6
//22.4 타입제약 : 종종 제네릭함수가 처리해야 할 기능이 특정 타입에 한정되어야만 처리할 수 있던가. 제네릭 타입을 특정 프로토콜을 따르는 타입만 사용할 수 있도록 제약을 두어야 하는 상황이 발생할 수 있다.
//타입제약은 틀래스 타입 또는 프로토콜만 줄수 있다. 열거형, 구조체의 등의 타입은 타입제약의 타입으로 사용할 수 없다.


import Foundation

//where 절을 활용한 타입 매개변수와 연관 타입의 타입 제약 추가

func twoTimes<T> (integerValue: T) -> T where T: BinaryInteger {
    return integerValue * 2
}

//위의 함수와 같은 표현이다.
func anotherTwoTimes<T: BinaryInteger> (integerValue: T) -> T {
    return integerValue * 4
}

print(twoTimes(integerValue: 2))
print(anotherTwoTimes(integerValue: 2))
//print(doubled(integerValue: 2.0)) 2.0은 double이기 때문에 에러가 발생한다.  이것은

//코드 22-13
//뺄셈을 하려면 뺄셈 연산자를 사용할 수 있는 타입이어야 한다. 연산이 가능하다는 한계이다. T가 실제로 받아들일 수 있는 타입은 뺄셈 연산자를 받아들일 수 있는 타입이어야 한다. 
func substractTwoValues<T: BinaryInteger>(_ a: T, _ b: T) -> T {
    return a - b
}

print(substractTwoValues(4, 5))
