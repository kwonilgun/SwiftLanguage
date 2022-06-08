
import Foundation
import Security

//23. 프로토콜 지향 프로그램밍
//익스텐션은 기존 타입의 기능을 확장하여, 프로토콜을 채택한 타입이 원하는 기능을 강제로 구현한다는 점
//특정 프로토콜을 정의하고 여러 타입에서 이 프로토콜을 준수하게 만들어 타입마다 똑같은 메소드, 프로퍼티, 서브 스크립트등을 구현해야 한다면, 얼마나 많은 코드를 중복사용해야 하며, 유지 보수는 얼마나 힘들어지 생각만해도 머리가 아프다. 이때 필요한 것이 바로 익스텐션과 프로토콜의 결합이다. 

//💇‍♀️ 💇‍♀️ :프로토콜은 정의할 때는 그 프로토콜의 요구 사항을 구현할 수는 없다. 단지 요구사항을 정의할 따름이다. 익스텐션에서 프로토콜의 요구사항을 구현할 수 있다. 


//프로토콜의 익스텐션에는 프로토콜이 요구하는 기능을 실제로 구현해줄 수 있다. 다만 익스텐션에는 저장 프로퍼티를 구현할 수 없으므로 저장 프로퍼티는 각각의 타입에서 직접 구현을 해야 한다. 이렇게 프로토콜과 익스텐션을 결합하면 코드의 재 사용성이 월등히 증가한다.

//이처럼 프로토콜의 요구사항을 익스텐션을 통해 구현하는 것을 프로토콜 초기구현이라고 한다.
//

protocol Receivable {
    func received(data: Any, from: Sendable)
}

extension Receivable {
    func received(data: Any, from: Sendable) {
        print("\(self) received \(data) from \(from)")
    }
}

protocol Sendable {
    var from: Sendable { get }
    var to: Receivable? { get }
    
    func send(data: Any)
    static func isSendableInstance(_ instance: Any) -> Bool
}

extension Sendable {
    var from: Sendable {
        return self
    }
    
    func send(data: Any) {
        guard let receiver: Receivable = self.to else {
            print("메시지를 받지 않음")
            return
        }
        
        receiver.received(data: data, from: self.from)
    }
    
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}

//수신, 발신이 가능함 메세지 클래스
//옵셔널 저장 프로퍼티이다. 이것은 클래스의 초기화가 필요가 없다.

class Message: Sendable, Receivable {
    var to: Receivable?
}

//수신, 발신이 가능한 메일 클래스
class Mail: Sendable, Receivable {
    var to: Receivable?
}

let myPhoneMessage: Message = Message()
let yourPhoneMessage: Message = Message()

//아직 수신 받을 인스턴스가 없다.
myPhoneMessage.send(data: "Hello")

//수신 받은 인스턴스 지정
myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")

print(Message.isSendableInstance("Hello"))          //false
print(Message.isSendableInstance(myPhoneMessage))   //true

