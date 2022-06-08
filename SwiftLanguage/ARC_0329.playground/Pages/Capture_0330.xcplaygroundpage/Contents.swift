//프로그램: ClosureSRCFix_0118.playground

import Foundation

//획득목록
//클로저 내부에서 참조타입을 획득하는 규칙을 제시해준다.
//획득목록을 사용하면 때에 따라서, 혹은 각 관계에 따라서 참조방식을 클로저에 제안할 수 있습니다.
//획득목록은 참조방식과 참조할 대상을 대괄호([])로 둘러싼 목록 형식으로 작성하며 획득목록 뒤에는 in 키워드를 써 줍니다. 획득목록에서 명시한 요소가 참조타입이 아니라면 해당 요소들은 클로저가 생성될 때 초기화됩니다.


//획득목록을 통한 값 획득
var a = 0
var b = 0

//a는 클로저가 생성될 때 값을 획득해서 초기화된다. 그럼으로 a는 0 이된다. b는 외부에서 정하는 대로 값이 변한다.
let closure = { [a] in
    print(a, b)
    b=20
}

a = 5
b = 10
closure()   // 0 10
print(b)    // 20


// 참조 타입의 획득목록 동작
class SimpleClass {
    var value: Int = 0
    
    deinit {
        print("SimpleClass 메모리 해제")
    }
}

var x = SimpleClass()
var y = SimpleClass()

let closureA = { [x] in
    print(x.value, y.value)
}

closureA()

x.value = 10
y.value = 20

//참조값을 획득하기 때문에 즉 포인터를 획득했기 때문에 x.value 값을 변경하면 값이 변하는 것이다. 포인터 값은 고정이다.
closureA()  //10, 20

//획득목록의 획득 종류 명시

var xx: SimpleClass? = SimpleClass()
var yy = SimpleClass()

let closureAA = { [weak xx, unowned yy] in
    print(xx?.value ?? "nil", yy.value)
}

xx = nil   // 약한 참조이기 때문에 deinit이 된다. 
yy.value = 10

closureAA()


// weak 획득 목록 -> 메모리 리크 문제 해결
// 클로저도 참조 타입이기 때문에 , class도 참조 타입이기 때문에 강한 참조가 발생한다. 


class Person {
    let name: String
    let hobby: String?
    
    
    //여기서 introduce는 클로저이다. 클로저 변수이다. 이 클로저를 lazy와 연동을 하면 나중에 실행이 되는 것이다. 이렇게 되면 강한 참조가 발생할 수 있다. self의 인스턴스 메소드를 호출할 때 값 획득이 발행할 수 있다. 클로저가 self를 획득하므로 강한 참조 순환이 발생한다. 즉 self는 class Person의 인스턴스 이기 때문이다.
    //클로저는 자신이 호출되면 언제든지 자신의 내부의 참조들을 사용할 수 있도록 참조 횟수를 증가시킨다. 메모리에서 해제되는 것을 방지한다. 자신을 프로퍼티로 갖는 참조 횟수를 증가시킨다. 
    //self로 인해서 강한 참조발생하기 때문에 획득목록으로 문제를 해결해야 한다
    
    //[]는 참조 획득이다. 인스턴스를 획득하는 것이다. self는 인스턴스를 나타내기 때문에 자연스럽게 참조가 되고 강한 참조가 발생이 된다. 이것을 약한 참조인 weak로 자연스럽게 참조문제를 해결하면된다.
    
    
    lazy var introduce: () -> String = { [weak self] in
        
        //dump(self)
        
        var introduction: String = "My name is \(String(describing: self?.name))."
        
        guard let hobby = self?.hobby else{
            return introduction
        }
        
        introduction += " "
        introduction += "My hobby is \(hobby)"
        return introduction
    }
    
    init(name: String, hobby: String? = nil) {
        self.name = name
        self.hobby = hobby
    }
    deinit {
        print("\(name) 구조체 해제")
    }
}

var kwon: Person? = Person(name: "Kwon", hobby: "Golf")
print(kwon?.introduce() ?? "없음")
kwon = nil  // 메모리 해제 된다. 
