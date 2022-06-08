import SwiftUI

//Swift의 동시성 모델은 다양한 동시성 버그들로부터 안전한 프로그래밍 환경을 제공하기 위해 만들어졌다. 이 중에서도 대표적인 버그 상황은 바로 data race 컨디션으로, 각자 다른 스레드에서 같은 데이터에 접근할 때 생기는 문제점이다.
//지난 번에 작성한 Structed Concurrency에서도 data race를 방지하기 위해 컴파일러 단위부터 검사해주고 있음을 알 수 있었는데, 그걸 가능하게 하는 것이 바로 Actor다.
//프로그래머는 Actor로 ‘하나의 동시성 영역’ 안에서 유지되는 상태의 모임을 만들 수 있고, 이 Actor가 여러가지 명령을 수행할 수 있도록 설정할 수 있다. 각 Actor는 각자의 data를 ‘Actor Isolation’이라는 개념을 이용해 보호한다. 이를 통해 한 데이터에 동시에 단 하나의 스레드만 접근할 수 있도록 해 의도치 않은 data race를 막을 수 있다.

actor BankAccount {
    let accountNumber: Int
    var balance: Double
    
    init(accountNumber: Int, initialDeposit: Double) {
        self.accountNumber = accountNumber
        self.balance = initialDeposit
    }
    
}


extension BankAccount {
    enum BankError: Error {
        case insufficientFunds
    }
    
    func transfer(amount: Double, to other: BankAccount) throws {
        if amount > balance {
            throw BankError.insufficientFunds
        }
    
    
        print("Transferring \(amount) from \(accountNumber) to \(other.accountNumber)")
        
        //other.balance = other.balance + amount
    }
}
