

import Foundation

//Nested Type
//open, public타입 또는 internal타입에 정의 된 중첩 타입은 자동으로 internal접근 레벨을 가집니다.
//💇‍♀️ -> Nested 구조체는 자동으로 internal 접근 레벨을 가지기 때문에 외부 소스에서 접근을 하면 에러가 발생을 한다. 
let myInstance = SomeOpenClass.myStruct(name: "Kwon")
