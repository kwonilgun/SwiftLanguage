//Overflow Operators (값 넘침 연산자)

//해당 값을 쥘 수 없는 정수 상수나 변수에 수를 집어 넣으려고 하면, 기본적으로 스위프트는 무효한 값을 생성하기 보다는 에러를 보고합니다. 이런 동작은 너무 크거나 작은 수와 작업할 때 부가적인 안전성을 부여합니다.
//
//예를 들어, Int16 정수 타입은 -32768 과 32767 사이의 어떤 ‘부호있는 정수’ 든 쥘 수 있습니다. Int16 상수나 변수에 이 범위를 밖의 수를 설정하려고 하면 에러를 일으킵니다:


import Foundation

//var max = Int16.max
//max += 1    //에러가 발생을 한다. overflow가 발생하기 때문이다.



var signedOverflow = Int8.min    // -128
signedOverflow = signedOverflow &- 1

print(signedOverflow)  //127
