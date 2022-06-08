//: [Previous](@previous)

import Foundation

protocol Sendable {
    var to: String { get }
    
}

protocol Receivable{
    var at: String { get }
    //var from: String { get set}
}

struct Mail: Sendable, Receivable {
    var at: String
    var to: String
    
    var from:String {
        get {
            return to
        }
        
        set {
            to = newValue
        }
    }
    
    
}

//이것은 다운 캐스팅을 한다. 캐스팅을 할 수가 있다. 타입이 변경되는 것이 아니고 Receivable 인스턴스처럼 행동을 한다.
var mail = Mail(at: "권일근", to: "hello")

var mail_R = mail as Receivable
//print(mail.from)
print(type(of: mail_R))
print(mail_R.at)

//이것도 다운 캐스팅을 한다.
var mail_S = Mail(at: "박선미", to: "world") as Sendable
print(type(of: mail_S))
print(mail_S.to)


//여기서는 mail_R과 mail_S 는 모두 Mail 프로토콜 타입이다. 그럼으로
//Mail은 프로토콜적으로 Receivable, Sendable이기 때문에, 변환을 자유자재로 할 수 있다. mail_R은 Receivable로 타입 캐스팅되어다가 Sendable로 타입 캐스팅 된다. 

// as? 는 실패할 수 있기 때문이다. 즉 if let 이기 때문에 그렇다.
if let castedInstance = mail_R as? Sendable {
    print("Sendable 캐스팅")
    print(castedInstance.to)
    
}

if let castedInstance = mail_S as? Receivable {
    print("Receivable 캐스팅")
    print(castedInstance.at)
}

//switch는 실패의 경우가 없어서 항상 as 로 처리를 한다.
//타입 캐스팅 패턴이다.
switch mail_R {
    
//타입 확인과 동시에 캐스팅까지 완료되어 value에 저장한다. 
case let x as Sendable : print("switch: \(x) Sendable")
case let y as Receivable : print("switch: \(y) Receivable")
default: ()
}
