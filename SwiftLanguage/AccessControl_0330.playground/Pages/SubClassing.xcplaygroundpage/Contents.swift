

import Foundation

//서브클래스는 슈퍼클래스보다 높은 접근 레벨을 가질 수 없습니다. 예를들어, internal 슈퍼클래스로, public서브클래스를 작성 할 수 없습니다.


//💇‍♀️-> superclass는 internal access이고, subclass는 public access이기 때문에 에러가 발생한다.
class SomeInternalClass { }

public class PublicClass: SomeInternalClass{ //Error
    
}


// 정상적인 상속이다.
//public class A {
//
//}
//internal class B: A {
//
//}

//override를 사용하면, 상속된 클래스 멤버가 슈퍼클래스 버전보다 더 쉽게 접근 할 수 있습니다. (그러니까 덜 제한적인 접근 수준을 가질 수 있다는 소리)
public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {}
}

//💇‍♀️->서브 클래스가 override을 하기 때문에 접근을 internal로 상향할 수 있다.



//💇‍♀️ -> 서브클래스 멤버가 서브클래스 멤버보다 액세스 권한이 더 제한적인 슈퍼 클래스 멤버를 호출하는것도 유효합니다.
//같은 파일내에 있다면, 일단 someMethod()를 override하는 게 가능할 테고!!! 근데 override할 때 덜 제한적인 접근 수준으로 만들 수 있다고 했죠?
//그 override(재정의)내에서!!!! 내 슈퍼클래스의 원래 구현을 호출할 수 있다는 겁니다. 물론 해당 메소드나 프로퍼티의 접근 수준에 접근 할 수 있는 컨텍스트 안에 있다고 했을때요! 지금은 같은 소스파일 내에 있으니, 슈퍼클래스의 someMethod()를 호출 할 수 있는 거겠죠?

public class C {
    fileprivate func someMethod() {}
}

internal class D: C {
    override internal func someMethod() {
        super.someMethod()
    }
}


//상수, 변수 또는 프로퍼티는 해당 타입보다 덜 제한적일 수 없습니다. : 더 제한적이어야 한다. 이중부정이다.


class F {
    init() {}
}

//public var instance = F()  //Error

var stance = F()
fileprivate var stan = F()
private var stanc = F()
