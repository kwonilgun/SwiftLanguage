//Unowned References

import Foundation

//Unlike a weak reference, an unowned reference is expected to always have a value. As a result, marking a value as unowned doesn’t make it optional, and ARC never sets an unowned reference’s value to nil’
//Unowned는 옵셔녈이 아니다. 값을 가지고 있다. 실제 값을 가지고 있는 변수 앞에 unowned을 붙인다. 항상 값을 가지고 있다.

//‘The relationship between Customer and CreditCard is slightly different from the relationship between Apartment and Person seen in the weak reference example above. In this data model, a customer may or may not have a credit card, but a credit card will always be associated with a customer. A CreditCard instance never outlives the Customer that it refers to. To represent this, the Customer class has an optional card property, but the CreditCard class has an unowned (and non-optional) customer property.’

//customer와 creditcard 사이의 관계 - customer는 credit card를 가지고 있을 수도 있고, 아닐 수도 있다. CreditCard 는 항상 커스터머를 가지고 있다. 옵셔널이 아니다. 이런경우  unowned 를 앞에 붙여서 강한 순환 참조 문제를 해결한다.

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer  //항상 값을 가지고 있고, unowned를 붙여서 문제를 해결한다.
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}


var john: Customer?   //이것은 초기화가 nil 이 된다.

john = Customer(name: "John Adams")
john?.card = CreditCard(number: 123_4568, customer: john!)
//dump(john)
john = nil


//💇‍♀️-> john이 디이니셜라이저 되면 자동으로 john이 해제가 된다. CreditCard에 있는 customer가 john으로 되어 있디만 unowned로 선언이 되어 있어서 reference count가 증가하지 않기 때문에 john=nil 을 수행하면 자동으로 해제가 되고 Card의 인스턴스도 자동으로 해제가 된다.
