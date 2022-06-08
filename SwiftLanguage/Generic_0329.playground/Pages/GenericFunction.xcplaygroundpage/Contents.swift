import Foundation
//22. Generic
/*
 제네릭을 이용해 코드를 구현하면 어떤 타입에도 유연하게 대응할 수 있다. 또한 제네릭으로 구현한 기능과 타입은
 재사용하기도 쉽고, 코드의 중복을 줄일 수 있기에 깔끔하고 추상적인 표현이 가능하다.
 Array, Dictionary, Set 등의 타입이 모두 제네릭 컬렉션이다.
 */

//제네릭 타입과 제네릭 함수가 있다.

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print(someInt, anotherInt)

//제네릭 함수 : 문제점 리뷰
var stringOne: String = "A"
var stringTwo: String = "B"

func swapTwoString(_ a: inout String, _ b: inout String) {
    let tempA = a
    a = b
    b = tempA
    
}

swapTwoString(&stringOne, &stringTwo)
print(stringOne, stringTwo)


func swapTwoAny(_ a: inout Any, _ b: inout Any) {
    let tempA: Any = a
    //print(a,b)
    a = b
    b = tempA
}

var numberOne: Any = stringOne
var numberTwo: Any = stringTwo

print(swapTwoAny(&numberOne, &numberTwo))
print(numberOne, numberTwo) // B A
print(stringOne, stringTwo) // A B

//print(swapTwoAny(&stringOne, &stringTwo)) : Any 외에는 다른 타입의 전달이 불가하다.


//Any 타입의 inout 매개변수를 통해 전달될 전달인자의 타입은 Any로 전달이 되어야 한다.
// swapTwoValues(&stringOne, &stringTwo) // 오류가 발생한다.  Any 외 다른 타입의 전달인자 전달 불가하다.
//결국 CopyIn-CopyOut 이기 때문에 String 타입은 Any 매개변수에 전달이 되지 않는다. 그래서 Any로 변경한 후에 전달이 되어야 한다.
//String 타입의 변수를 전달인자로 전달할 수가 없다. String 타입의 값을 Any 타입의 변수에 넣어서 함수를 호출해야 하는 데, 그 순간 값은 복사가 된다. 즉 새로운 변수로만 함수를 호출할 수 있다. 💇‍♀️💇‍♀️💇‍♀️ -> 이부분이 핵심이다. 즉 stringOne과 stringTwo의 값을 교환할 수 없다.


//이 문제에 대한 해결책
//T의 실제 타입은 함수가 호출되는 그 순간 결정이 된다. Int 타입의 변수가 전달인자로 전달되었다면 T는 Int가 되고, String 타입의 변수가 전달인자로 전달되었다면 그 호출 순간에 T는 String이 된다.

//‘The generic version of the function uses a placeholder type name (called T, in this case) instead of an actual type name (such as Int, String, or Double). The placeholder type name doesn’t say anything about what T must be, but it does say that both a and b must be of the same type T, whatever T represents. The actual type to use in place of T is determined each time the swapTwoValues(_:_:) function is called.

// T는 placeholder 이고 같은 타입이 되어야 한다. T는 함수가 호출될 때 결정이 된다.

func swapTwoValues<T> (_ a: inout T, _ b: inout T) {
    let tempA: T = a
    a = b
    b = tempA
}


swapTwoValues(&numberOne, &numberTwo)
print(numberOne, numberTwo)     // A, B  잘 작동이 된다.

swapTwoValues(&stringOne, &stringTwo)
print(stringOne, stringTwo)


//같은 타입끼리만 교환가능하다.

//타입 매개변수를 지정해주면 이를 함수의 매개변수의 타입으로 사용할 수가 있다. 또한 함수의 반환타입으로 사용할 수 있다. 함수 내부의 타입 지정을 위해 사용할 수 있다. 각각의 경우 매개변수는 함수 호출할 때마다 실제 타입으로 치환된다. 호출할 때마다 자동으로 치환이 된다. 


//먼저 전위 연산자를 정의해야한다. 기존에 없던 전위연산자를 만들기 위해서는 연산자 정의를 먼저해야 한다.
//T는 placeholder 이다. T에 대해서 Protocol 준수로 제약을 줄 수 있따.
prefix operator **

prefix func ** <T:BinaryInteger> (value: T) -> T {
    return value * value * 10
}
let square: Int = **5
let squareUInt: UInt = **10
print(square)
print(squareUInt)


var array: Array = Array<String>()

array.append("Hello")
array.append("Wolrd")
array.append("kwon")

print(array)
print(array.index(after: 0))
print(array.startIndex)
print(array.endIndex)
print(array[1])
