import Foundation


//타입의 접근 수준을 internal 또는 public으로 정의하거나(접근 수준을 명시적으로 지정하지 않고, 기본 접근 레벨을 사용하는 경우 => internal이겠죠?) 타입 구성원의 기본 접근 수준은 internal입니다.
//
//이게 무슨말이냐면, internal일 경우에는 구성원들이 기본적으로 internal로 되는건 당연하지만 public??...public도 인가요?
//(지금 해보니..open으로 해놔도 기본 접근 수준이 internal이네요)
//
//그러니까 여기서 헷갈릴 수 있는 점은, internal, file-private, private로 접근 수준을 지정해 놓으면 그 안 구성원들은 자동으로 해당 타입의 접근 수준을 따라가지만, public과 open의 경우에는 따로 명시해놓지 않으면 internal로 기본 접근 수준이 정해진다는 소리입니다. 각각 public과 open이 되는 것이 아니라요.
//


//이 PublicClass는 접근수준이 public이기때문에, 내부모듈은 물론이고, 외부모듈에서 접근이 가능하죠.
//하지만 이니셜라이저와 메소드에는 아무 접근 수준을 명시적으로 지정해주지 않았어요.
//====> 이러면 뭐다?????기본적으로 internal이 된다 ㅇㅇㅇ
//
//💇‍♀️->즉!!!! 외부모듈에서 이 PublicClass가 인식은 되지만!!!!!  이니셜라이저가 기본적으로 internal이기때문에, 외부모듈에서는 이 PublicClass의 인스턴스를 만들 수가 없습니다.


//💇‍♀️-> 기본적으로 접근 수준을 명시적으로 지정해 주지 않으면 internal 이 된다.

//someMethod' is inaccessible due to 'internal' protection level
//public someMethod로 선언을 하지 않으면 internal protection level 에러 메세지가 뜬다. 그래서 public 을 추가하면 사용할 수가 있다.


//외부 모듈에서 접근을 하는 경우는 모두 public으로 선언을 해 주어야 한다. 내부 모듈인 경우는 문제가 없다. 
public class PublicClass {
    
    //public으로 init() 를 선언하지 않으면 외부 모듈에서 이 class를 인스턴스화 하는 경우 에러가 발생을 한다. 
    
    init(){}
    //public init() {}
    
    public func someMethod() {
        
        print("someMethod in PublicClass")
    }

}


