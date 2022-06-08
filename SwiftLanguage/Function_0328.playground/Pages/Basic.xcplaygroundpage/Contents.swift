//: [Previous](@previous)

import Foundation

//함수는 일급 객체이기 때문에 하나의 값으로 사용될 수 있다.
//구조체, 클래스, 열거형 등 특정 타입에 연관되어 사용하는 함수를 메소드,
//모듈 전체에서 전역적으로 사용할 수 있는 함수를 그냥 함수라고 부른다.


//매개변수 hello(name: "Jenny") -> name: 매개변수, "Jenny": 전달인자.
//전달인자 레이블
//func 함수이름(전달인자 레이블  매개변수 이름: 매개변수 타입) -> 반환타입 {
//              실행구문
//              return 반환 값
//  }
//

func sayHello(from myName: String) -> String {
    return "Hello" + myName
}


//from 전달인자 레이블, "권일근": 전달인자, myName: 매개변수,
var hello: String = sayHello(from: " 권일근")

print(hello)


//가변 파라미터
/***가변 파라미터 (variadic parameter) 는 0개 이상의 특정 타입의 값을 허용합니다. 함수가 호출될 때 여러개의 입력값이 전달될 수 있는 특정 파라미터는 가변 파라미터를 사용합니다. 가변 파라미터는 파라미터의 타입 이름 뒤에 세개의 기간 문자 (...)를 추가하여 작성합니다.
 ***/
//가변 매개변수로 들어오는 인자 값은 배열처럼 사용할 수 있다.

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    
    return total/Double(numbers.count)
}


print("평균값=\(arithmeticMean(1,2,3,4,5))")
