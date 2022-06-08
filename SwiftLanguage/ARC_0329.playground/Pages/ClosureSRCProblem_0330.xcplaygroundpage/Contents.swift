// 프로그램: StrongReferCycle_0117.playground

///프로그램: StrongReferenceCycle.playground

//클로저의 강한 참조 순환
//강한참조 순환 문제는 클로저가 인스턴스의 프로퍼티일 때나, 클로저의 값 획득 특성 때문에 발생한다.
//강한참조 순환이 발생하는 이유는 클로저 또한 참조 타입이기 때문에 발생
//이런 클로저의 강한 참조 순환 문제는 클로저의 획득목록을 통해 해결할 수 있다.

//여기서 introduce는 클로저이다. 클로저 변수이다. 이 클로저를 lazy와 연동을 하면 나중에 실행이 되는 것이다. 이렇게 되면 강한 참조가 발생할 수 있다. self의 인스턴스 메소드를 호출할 때 값 획득이 발행할 수 있다. 클로저가 self를 획득하므로 강한 참조 순환이 발생한다. 즉 self는 class Person의 인스턴스 이기 때문이다.
//self로 인해서 강한 참조발생하기 때문에 획득목록으로 문제를 해결해야 한다

import Foundation

class Person {
    let name: String
    let hobby: String?
    
    
   
    
    lazy var introduce: () -> String = {
        
        var introduction: String = "My name is \(self.name)."
        
        guard let hobby = self.hobby else{
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

var kwon: Person? = Person(name: "권일근", hobby: "골프")
print(kwon?.introduce())
kwon = nil  //이렇게 해도 deinit를 하지 않는다.


//Person 클래스의 introduce 프로퍼티에 클로저를 할당한 후 클로저 내부에서 self 프로퍼티를 사용할 수 있었던 이유는 introduce가 지연 저장 프로퍼티이기 때문이다. 만약 지연저장 프로퍼티가 아니라면 이렇게 self를 사용하여 접근할 수 없었을 것이다. lazy 프로퍼티로 할당한 클로저 내부에서 Person 클래스 인스턴스의 다른 인스턴스 프로퍼티에 접근하려면 Person 클래스이 인스턴스가 모두 초기화되어 사용이 가능한 상태에서만 클로저에 접근할 수 있다. 따라서 클로저 내부에서는 self 프로퍼티를 통해서만 다른 프로퍼티에 접근할 수 있다.

//introduce 프로퍼티를 통해 클로저를 호출하면 , 그 때 클로저는 자신의 내부에 있는 참조 타입 변수를 획득합니다. 문제는 여기서 시작이 됩니다 클로저는 자신이 호출되면 언제던지 자신 내부의 참조들을 사용할 수 있도록 참조횟수를 증가시켜 메모리에서 해제 되는 것을 방지한다. 프로퍼티로 갖는 인스턴스의 참조횟수도 증가시킨다. 💇‍♀️ 💇‍♀️self를 위해서 자체적으로 참조 횟수를 자동으로 증가한다. 이로 인해서 참조 횟수가 1 증가함으로 kwon 변수에 nil을 할당해도 인스턴스가 메모리에서 해제되지 않는다. <-- : 이부분이 가장 핵심이 된다.

//클로저 내부에서 self 프로퍼티를 여러번 호출하여 접근해도 참조 횟수는 한번만 증가한다.

//self로 인해서 참조횟수를 증가시키지 않는 유일한 방법은 self를 획득해서 weak로 만들어 주는 방법 밖에 없다.

//[weak self] self를 획득하고 weak reference 처리함으로써 메모리 leak 문제를 해결할 수 있다.
