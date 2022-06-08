//프로그램: ARC_0117.playground

//ARC : Automatic reference count

//Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage. In most cases, this means that memory management “just works” in Swift, and you don’t need to think about memory management yourself. ARC automatically frees up the memory used by class instances when those instances are no longer needed.’

//클래스만 해당이 된다.

//클래스의 인스턴스를 생성할 때마다 ARC는 그 인스턴스에 대한 정보를 저장하기 위해 메모리 공간을 따로 또 할당한다. 메로리 공간에는 인스턴스의 타입 정보와 함께 그 인스턴스와 관련된 저장 프로퍼티의 값 등을 저장한다.

//강한 참조 횟수
// 인스턴스가 계속해서 메모리에 남아 있어야 하는 명분을 만들어 주는 것이 바로 강한참조이다. 인스턴스는 참조횟수가 0이 되는 순간 메모리에서 해제된다. 인스턴스를 다른 인스턴스의 프로퍼티나 변수, 상수 등에 할당할 때 강한 참조를 사용하면 참조횟수가 1 증가한다. 강한 참조를 사용하는 프로퍼티, 변수, 상수 등에 nil을 할당해주면 원래 자신에게 할당되어 있던 인스턴스의 참조횟수가 1 감소된다.

//참조 기본은 강한 참조이므로 클래스 타입의 프로퍼티, 변수, 상수 등을 선언할 때 별도의 식별자를 명시하지 않으면 강한 참조를 합니다. 이제까지

import Foundation

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) 초기화")
    }
    deinit {
        print("\(name) 구조체 해제")
    }
}


//인스턴스를 다른 인스턴스의 프로퍼티나 변수, 상수 등에 할당할 때 강한 참조를 사용하면 참조 횟수가 1 증가한다. 또한 강한 참조를 사용하는 프로퍼티, 변수, 상수 등에 nil을 할당하면 원래 자신에게 할당되어 있던 인스턴스의 참조 횟수가 1 감소한다.


//강한 참조이다 : 프로퍼티, 변수, 상수는 기본적으로 강한 참조이다. 여기서
var reference: Person?
var strongRef1: Person?
var strongRef2: Person?

//Person 클래스 타입의 인스턴스는 처음 메모리에 생성이 된 후에 강한 참조로 reference로 할당되기 때문에 참조횟수가 1 증가한다. 즉 참조횟수이다. 자동으로 참조횟수가 증가를 한다. 계속 할당이 되면 참조횟수는 증가를 하는 것이다.

reference = Person(name: "Kwon")  //인스턴스 참조 횟수 1
strongRef1 = reference          //인스턴스 참조 횟수 2
strongRef2 = reference          //인스턴스 참조 횟수 3


//아무 선언을 하지 않으면 강한 참조가 된다. 기본이 강한 참조이다. 인스턴스가 메모리에 남아 있어야 한다.
reference = nil
strongRef1 = nil
strongRef2 = nil

//약한 참조
//약한 참조
//약한 참조는 강한 참조와 달리 자신이 참조하는 인스턴스의 참조횟수를 증가시키지 않는다. 참조 타입의 프로퍼티나 변수의 선언 앞에 weak 키워드를 써주면 그 포로퍼티나 변수는 자신이 참조하는 인스턴스를 약한 참조로 만든다.
var reference1: Person?
weak var reference2: Person?    //약한 참조이기 때문에 참조횟수가 증가하지 않는다.
weak var reference3: Person?

reference1 = Person(name: "John")  // 참조횟수 :1
reference2 = reference1 //참조횟수 : 1
reference3 = reference1  //참조횟수 : 1
reference1 = nil    //인스턴스의 참조횟수: 0


//Person 타입의 인스턴스는 이니셜라이저에 의해 생성된 후 kwon 상수에 할당할 때 참조 횟수가 1이 된다. 그리고 강한 참조 지역변수가 사용된 범위의 코드 실행이 종료되면 그 지역 변수가 참조하던 인스턴스의 참조횟수가 1 감소한다.

//강한 참조
func foo() {
    let kwon: Person = Person(name: "kwonilgun")
    //인스턴스 참조횟수 : 1
    print(kwon.name)
    
    //함수종료 시점, 인스턴스 참조횟수 : 0
}

foo()


//강한 참조 지역변수의 참조 횟수 확인과 전역 변수

var globalReference: Person?

func foo_G() {
    
    let yagom: Person = Person(name: "yagom") //참조횟수 1 증가
    
    globalReference = yagom //참조횟수 2 증가
    
    //함수 종료 시점
    //인스턴스의 최초 횟수: 1
    
}

foo_G()
//이번에 인스턴스가 강한 참조를 하는 전역변수 globalReference에 강한참조되면서 참조횟수가 1 더 증가하여 2가 되었다. 그 상태에서는 함수가 종료되면 참조횟수가 1 감소하여도 여전히 참조 횟수가 1이므로 메모리에서 해제되지 않는다.


//여기서 비로소 해제가 된다.
globalReference = nil

//Strong Reference Cycle


