
//ExtensionExample.playground

import UIKit

/*
 확장(Extensions)
 
 가장 강력한 기능 중 하나이다.
 
 확장은 기존 클래스, 구조체 또는 열거형, 프로토콜 타입에 새로운 기능을 추가한다. 기존 소스 코드에서 접근하지 못하는 타입들을 확장하는 능력이다(소급 적용 모델링). 확장은 Objective-C의 카테고리와 유사하다(Swift 확장은 이름을 가지지 않는다는 점에서 Objective-C 카테고리와는 다르다.).

 Swift에서 확장은 다음 기능을 할 수 있다:

 계산 속성과 계산 정적 속성 추가
 인스턴스 메소드와 타입 메소드 정의
 새로운 이니셜라이저 제공
 서브스크립트 정의
 새로운 중첩 타입 정의와 사용
 기존 타입에 프로토콜 적용하기
 */
//Double 테스트
//스위프트 표준 라이브러리 에서 double의 정리
// ....
// public init?(exactly other: Float)
// ...
// extens

let someValue: Double? = Double(exactly: 1.2)   //실패가능한 초기화 init? 이기 때문에 Double? 옵션으로 처리한다. 
let someString = String(describing: someValue)
//print(someString)
//print(someValue)
//dump(someValue)
//print(someValue?.description ?? "nil")


extension Double {
//    var details: String { return String(self) }
     var description: String { return "값은: \(self)" }
    
}

print(someValue?.description as Any)
//print(String(describing: someValue))


//var description: String { get }  이것을 타입 안에서 구현을 해 주면
//String(describing: )으로 스트링을 이용할 수 가 있다.

struct Point: CustomStringConvertible {
         let x: Int, y: Int

         var description: String {
             //return "(\(x), \(y))"
             return "x 값은 : \(x), y 값은 : \(y)"
         }
}

let p = Point(x: 21, y: 30)

print(p.description)

let s = String(describing: p)   //결국 Point에서 구현한 description이 String(describing: p)로 구현이 된다.

print(s)
// Prints "(21, 30)"


//익스텐션은 타입에 기능을 추가할 수 있지만, 기존에 존재하는 기능을 재 정의할 수는 없다.
//Double 또한 구조체 타입이다.


//Computed Properties 확장
extension Double {
    var km: Double { return self * 1000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1000.0 }
    var ft: Double { return self / 3.28084 }
}

let meter = 25.4.m
print(" meter:\(meter)")

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// prints "Three feet is 0.914399970739201 meters"


/*
 확장은 기존 타입에 계산 인스턴스 속성과 계산 타입 속성을 추가할 수 있다. 다음은 다섯개의 계산 인스턴스 속성을 Swift에 탑재된 Double 타입에 추가하는 예제이다.
 */
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    var isOdd: Bool {
        return self % 2 != 0
    }
}

var integer: Int = 6
if integer.isEven {
    print("짝수")    
}
else { print("홀수")}

print(1.isEven)
print(1.isOdd)


//메소드
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}


//여기서 self 는 인스턴스이다. 자체 인스턴스에 데이타 값을 다시 넣기 때문에 초기화를 진행할 수가 있다.
extension Int {
    init(dataInput: Int) {
        //💇‍♀️이것도 결국 자신을 변경하는 것이다. Int가 구조체이기 때문에 가능한 것이다.
        self = dataInput
    }
}

var dataInt: Int = Int(dataInput: 100)
print("dataInt: \(dataInt)")


func ft() -> Void {
    print("hello")
    print("world")
}

2.repetitions (task: ft)
3.repetitions {
    print("IG Kwon")
    print("SM Park")
}



/*
 이니셜라이저(Initializers)

 타입의 정의 부분에 이니셜라이저를 추가하지 않더라도 extension을 통해서 이니셜라이저를 추가할 수 있다.
 
 익스텐션으로 특히 클래스 타입에 편의 이니셜라이저를 추가할 수 있지만, 지정 이니셜은 추가할 수 없다. 지정 이니셜라이저와 디이니셜라이저는 반드시 클래스 타입의 구현부에 위치해야 한다.
 
 값타입 즉 구조체와 이넘은 상관이 없다.

 확장은 클래스에 새로운 편의 이니셜라이저를 추가할 수 있으나, 새로운 지정 이니셜라이저나 디이니셜라이저를 클래스에 추가할 수 없다. 지정 이니셜라이저와 디이니셜라이저는 항상 기존 클래스 구현이 되어 있어야 한다.
 */


//💇‍♀️💇‍♀️구조체이기 때문에 즉 값 타입이기 때문에 지정 이니셜라이저를 확장할 수 있다. 비교가 된다. 중요하다!!!!!!
extension String {
    
    
    init(intTypeNumer: Int) {
        
        //💇‍♀️ : 여기서 self를 잘 볼 필요가 있다. self는 String 인스턴스 자체이다. 결국 자기 자시을 변경하는 것이다. 이것이 구조체이기 때문에 가능한 것이다.
        self = "인티져:\(intTypeNumer)"
    }
    
    init(doubleTypeNumber: Double) {
        self = "더블:\(doubleTypeNumber)"
    }
    
    
    //서브서크립트를 추가할 수 있다.
    subscript(appendValue: String) -> String {
        return self + appendValue
    }
    
    subscript(index: Int) -> String {
        var str: String = ""
        for _ in 0...index {
            str += self
        }
        return str
    }
}

print("abc"["def"])
print("abc"[3])

let stringFromInt: String = String(intTypeNumer: 10)
let stringFromDouble: String = String(doubleTypeNumber: 10.0)
print(stringFromInt)
print(stringFromDouble)


//💇‍♀️💇‍♀️클래스 타입의 extension은 지정 이니셜라이저를 추가할 수는 없다. 이것이 구조체와 비교가 된다. 그리고 편의 이니셜라이저는 추가할 수 있다.
class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let someOne: Person = Person(name: "권일근")
print(someOne.name)

//이것은 위의 convenience init()가 없는 경우와 비교가 된다.
//있는 경우는 name의 값을 초기화 하지 안해도 된다. 이것이 중요하다.
//초기화를 직접해도 되고 안해도  convenience init() 가 직접 한다.
class PersonConvenience {
    var name: String
    init(name: String) {
        self.name = name
    }
}

extension PersonConvenience {      //클래스의 init()의 확장이다.
    convenience init() {
        self.init(name: "Unknown")
    }
}

//이것이 extension을 사용해서 초기화를 추가한 것이다. 즉 편리하게 초기화를 할 수 있다.

let someOneC: PersonConvenience = PersonConvenience()
print(someOneC.name)

let someOneD: PersonConvenience = PersonConvenience(name: "박선미")
print(someOneD.name)
