//: [Previous](@previous)

import Foundation

//Bitwise operators enable you to manipulate the individual raw data bits within a data structure. They’re often used in low-level programming, such as graphics programming and device driver creation. Bitwise operators can also be useful when you work with raw data from external sources, such as encoding and decoding data for communication over a custom protocol.’


let initalBits: UInt8 = 0b00001111
let invertedBits = ~initalBits


let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits


//0가 insert 된다.
let unsignedInt: UInt8 = 0b11111111
print(unsignedInt)
let unsignedShift = unsignedInt << 1
print(unsignedShift)
print(unsignedInt >> 1)

print("''''''")
//부호값은 어떻게 할 수가 없다. 부호가 있는 것은 당연하게 받아들여야 한다. 
let signedInt: Int8 = 0b1111110
print(signedInt)        //126
print(signedInt << 1)      //-4
print(signedInt >> 1)


//이것은 왼쪽 시프트 부호가 있는 값을 왼쪽으로 2번 쉬프트하면 -1 이 된다.
let sign = signedInt << 2  //-1
print(sign)


//첫 번째로, -1 과 -4 를, 단순히 (부호 비트를 포함한) 모든 8 비트 ‘표준 이진 더하기’ 를 한 후, 8 비트 안에 맞지 않는 어떤 것이든 버림으로써, 더할할 수 있다는 것입니다:
//
//two complement negative addition
//
//두 번째로, ‘2의 보수 표현’ 은 음수 비트의 왼쪽 오른쪽 이동을 양수 같이 할 수 있게 해주며, 여전히 왼쪽으로 이동할 때마다 두 배 증가하고, 오른쪽으로 이동할 때마다 반으로 나누는 식으로 끝맺습니다. 이를 달성하기 위해, ‘부호있는 정수’ 를 오른쪽으로 이동할 때는, 부가적인 규칙을 사용합니다: ‘부호있는 정수’ 를 오른쪽으로 이동할 때는, ‘부호없는 정수’ 와 똑같은 규칙을 적용하지만, 왼쪽에 남은 ‘빈 자리’ 를, 0 보다는, 부호 비트 (sign bit) 로 채웁니다.
//
//two complement negative shift
//
//이 행동은, 산술 이동 (arithmetic shfit) 이라고 하는데, ‘부호있는 정수’ 가 오른쪽으로 이동한 후에도 똑같은 부호를 가지도록 보장합니다.5
//
//양수와 음수를 저장하는 특수한 방식 때문에, 어느 것이든 오른쪽으로 이동하면 점점 더 0 에 가까워집니다. 이 이동 중에 부호 비트를 똑같이 유지한다는 것은 음수 값이 0 에 가까워지더라도 음의 정수는 음수로 남는다는 의미입니다.

var signedInteger: Int8 = 0b0000100
print(signedInteger)

signedInteger = -0b0000100
print(signedInteger)

signedInteger = -127
print(signedInteger >> 1)
