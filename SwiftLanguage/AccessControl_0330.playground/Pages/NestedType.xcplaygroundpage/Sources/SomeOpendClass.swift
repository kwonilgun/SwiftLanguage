import Foundation

open class SomeOpenClass {
    public init() {}
//    public struct myStruct {
//        var name: String
//        public init(name: String) {
//            self.name = name
//        }
//    }
    
    //이렇게 하면 네스트 구조체가 기본적으로 internal 접근 수준이기 때문에 에러가 발생한다.
    //특히 init() 함수가 internal 접근수준이기 때문에 에러를 제거하기 위해서는   public  으로 강제적으로 선언을 해 주어야 한다.
    
    struct myStruct {
        var name: String
    }
}
