//1월 25일
// 프로퍼티 감시자를 사용하면 프로퍼티의 값이 변경됨에 따라 적절한 작업을 취할 수 있다.
//프로퍼티 값이 새로 할당될 때 마다 호출이 된다. 변경되는 값이 현재의 값과 같더라도 호출이 된다.
//프로퍼티 감시자에는 프로퍼티 값이 변경되기 직전에 호출하는 willSet 메소드와 프로퍼티의 값이 변경된 직후에 호출하는 didSet 메소드가 있다.

import SwiftUI

class Account {
    
    var credit: Int=0 {
        willSet {
            print("willSet: \(credit) ---> \(newValue)")
        }
        didSet {
            print("didSet: \(oldValue) ---> \(credit)")
        }
    }
}

let myAccount: Account = Account()
myAccount.credit = 1000


//전역변수와 지역변수 연산프로퍼티와 프로퍼티 감시자는 전역변수와 지역변수 모두에 사용할 수 있다.

var dollarInPocket: Double {
    get {
        return 100*100
    }
}


//get 과 리턴을 없앴다. 
var dollarInPocketNoReturn: Double {
    10 * 10
}
print(dollarInPocket)
print(dollarInPocketNoReturn)

