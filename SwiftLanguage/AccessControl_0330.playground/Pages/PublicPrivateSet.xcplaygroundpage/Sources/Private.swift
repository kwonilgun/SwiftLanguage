import Foundation

//자..이게 또 무슨말인가 싶죠? 갑자기 private(set)앞에 public이 붙었네요;;;
//(여기서 퀴즈. 구조체를 public으로 하고 아무 접근 지정자를 안붙히면 뭐라고 그랬죠? ==> internal)
//
//이제 이 TrackedString이라는 구조체를 외부모듈에서 접근 할 수 있다는 거네요!

//


public struct TrackedString {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}
