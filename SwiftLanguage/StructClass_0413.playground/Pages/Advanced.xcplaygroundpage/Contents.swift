//: [Previous](@previous)

import Foundation

//프로그램명: StructBasic_0111.playground
@resultBuilder
struct StringBuilder {
    
    static func buildBlock(_ components: String...) -> String {
        print("---->buildBlock<---")
        return components.joined(separator: "🧚‍♀️")
    }
}

@resultBuilder
struct EvenNumbers {
    static func buildBlock(_ components: Int...) -> [Int] {  //[Int] 를 리턴한다.
        components.filter { inputValue in
            inputValue.isMultiple(of: 2)
        }
    }
}

//2월 4일: 결국 위에서 구현한 변수 값에 클로저를 연산해서 값을 할당하는 방식에서
//ResultBulder를 통해서 가변 파라미터를 전달하고 이 가변이 String Array로 취급되어서
//buildBlock에 전달이 된다. 이것을 처리하면 return이 String이다.
@StringBuilder
var testBuild : String {
    "Kwon"
    "ILGUN"
}


//결국 이것은 같은 것이다.  { } 실행을 하고 return을 해서 String을 반환한다.
var testBuilderTrans: String {
    let finalOutput = StringBuilder.buildBlock("kwon", "ILGUN")
    return finalOutput
}

print("testBuild:\(testBuild), testTrans:\(testBuilderTrans)")

//ResultBuilder 구조체 응용
struct Person {
    var name: String
    var age : Int
    
    init(@StringBuilder content: () -> String) {
            self.name = content() //함수를 실행했을 때 buildBlock 함수 호출한다.
            self.age = 10
        
    }
    
    func display() {
        print("\(self.name) : \(self.age)")
    }
}

//함수빌더 function builder 인 @StringBuilder는 함수를 받는 것이다. 그래서 Person의 클러저를 전달한다. 함수로 전달되는 값이 buildBlock의 입력 값이 되고, buildBlock 함수가 호출되는 것은 넘겨받은 함수를 실행했을 때가 된다

//ResultBuilder로 구현되었다.
@StringBuilder func personInform () -> String {
    "권일근"
    "박선미"
}

//여기서는 resultBuilder 함수를 매개 변수로 넘겼다.
var personFun: Person = Person(content: personInform)
personFun.display()


//이것이 클로저를 매개 변수로 넘겼다.
var personFt: Person = Person {
    "권일근 "
    "박선미"
}

personFt.display()

//생성자 매개 변수에 추가해 주면 뷰 빌더처럼 인스턴스를 생성할 때 즉시 함수 빌더 기능을 적용해 줄 수 있다.
struct MyNumber<T> {
    let number: T
    @inlinable init(@EvenNumbers content: () -> T) {
        self.number = content()
    }
}


//resultBuilder에 구조체를 콜하는 경우
let myNumber = MyNumber {
    1
    2
    4
    8
}
print(myNumber.number)


//resultBuilder 에 함수를 콜하는 경우
//allChange() 라는 함수를 실행하면 [Int] 가 리턴이 된다.
@EvenNumbers
func allChange() -> [Int] {
    1
    2
    3
    4
    
}
print(allChange())


//resultBuilder에 변수를 콜 하는 경우
// myNumberT에 실행된 값 [Int]를 넣는다.
@EvenNumbers
var myNumberT: [Int] {
    1
    2
    3
}
print(myNumberT)
