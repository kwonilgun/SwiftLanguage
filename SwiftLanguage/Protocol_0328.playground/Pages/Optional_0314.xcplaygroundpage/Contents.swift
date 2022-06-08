//: [Previous](@previous)

import Foundation

//Optional Protocol Requirements
//You can define optional requirements for protocols. These requirements don’t have to be implemented by types that conform to the protocol. Optional requirements are prefixed by the optional modifier as part of the protocol’s definition. Optional requirements are available so that you can write code that interoperates with Objective-C. Both the protocol and the optional requirement must be marked with the @objc attribute. Note that @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.’

//옵셔널 프로토콜 요구사항을 정의할 수 있다. 이런 요구사항은 프로토콜 준수를 하는 타입에 의해서 구현될 필요는 없다. 구현을 선택적으로 할 수 있다. 구현이 안되어도 무방하다고 보면된다.

//이것들은 클래스에 의해서만 채택이될 수 있다. Object-C 클래스들로 부터 상속받은 클래스들과 다른 @objc 클래스에 의해서만 채택될 수 있다. 

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

//선택적 요구를 적용해서 프로토콜의 기능이 있으면 실행을 하는 구조이다.

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        //이것의 해석이 중요하다: increment는 함수이고, optional 프로토콜이다. 이 함수를 실행해서 값을 생성하고
        // 이 값은 옵셔널이다. 그래서 if let 구문을 통해서 amount 를 구하고, count += amount를 합산한 결과를 count에 저장한다.
        
        //여기가 핵심이다. 💇‍♀️💇‍♀️ -> forCount 가 매개변수 레이블이고, count 값을 넘긴다. 초기에는 count = 0 이 넘어간다. 이것이 혼란스러운 것이다.
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
            
       //dataSource에 옵셔널로 지정한 것이 fixedIncrement가 들어있으면 fixedIncrement 값을 amount에 저장을 하고 이 저장된 값을 count와 합산을 해서 count에 저장한다. 
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()

for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

print("===========")

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}
