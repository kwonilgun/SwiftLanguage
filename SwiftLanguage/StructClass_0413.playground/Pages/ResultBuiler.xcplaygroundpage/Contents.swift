
//프로그램명: StructBasic_0111.playground

import UIKit

@resultBuilder
struct EmptyBuild {
    static func buildBlock(_ components: String...) -> [String] {
        print(components)
        return components
    }
}

@EmptyBuild
var empty: [String] {
    "hello"
    "world"
}

print(empty)



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



//1. ResultBuilder로 구현되었다.
@StringBuilder func personInform () -> String {
    "권일근"
    "박선미"
}

//여기서는 함수를 불렀다.
var personFun: Person = Person(content: personInform)
personFun.display()


//이것이 클로저로 변환되었다.
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

//let myNumber = MyNumber {
//    1
//    2
//    3
//    4
//
//}


//resultBuilder에 구조체를 콜하는 경우
let myNumber = MyNumber <[Int]> ( content: {
    1
    2
    4
    8
})
print(myNumber.number)


//resultBuilder 에 함수를 콜하는 경우
@EvenNumbers
func allChange() -> [Int] {
    1
    2
    3
    4
    
}

print(allChange())


//resultBuilder에 변수를 콜 하는 경우
@EvenNumbers
var myNumberT: [Int] {
    1
    2
    3
}
print(myNumberT)
