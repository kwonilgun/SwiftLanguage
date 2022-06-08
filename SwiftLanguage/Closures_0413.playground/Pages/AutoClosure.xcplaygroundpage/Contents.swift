
import Foundation

//자동 클로저 (Autoclosures)
//자동 클로저 (autoclosure) 는 함수에 인자로 전달되는 표현식을 래핑하기 위해 자동으로 생성되는 클로저입니다. 인자를 가지지 않으며 호출될 때 내부에 래핑된 표현식의 값을 반환합니다. 이러한 구문상의 편의를 통해 명시적 클로저 대신에 일반 표현식을 작성하여 함수의 파라미터 주위의 중괄호를 생략할 수 있습니다.

//자동 클로저를 가지는 함수를 호출 하는 것은 일반적이지만 이러한 함수를 구현 하는 것은 일반적이지 않습니다. 예를 들어 assert(condition:message:file:line:) 함수는 condition 과 message 파라미터에 대한 자동 클로저를 가집니다. condition 파라미터는 오직 디버그 빌드인지 판단하고 message 파라미터는 condition 이 false 인지만 판단됩니다.

//클로저가 호출될 때까지 코드 내부 실행이 되지 않기때문에 자동 클로저는 판단을 지연시킬 수 있습니다. 판단 지연은 코드 판단 시기를 제어할 수 있기 때문에 사이드 이펙트가 있거나 계산이 오래 걸리는 코드에 유용합니다. 아래 코드는 클로저가 어떻게 판단을 지연하는지 보여줍니다.

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
//  아직 실행이 되지 않았다 그래서 값이 Prints "5"

print("Now serving \(customerProvider())!")
// 이제 클로저가 실행이 되었다. Prints "Now serving Chris!"
print(customersInLine.count)
// 그래서 Prints "4"


//..... 자동 클로저
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// 함수 인자를 표현하는 것과 동일한 효과 이다. Prints "Now serving Ewa!"


//..... 자동 클로저의 탈출 클로저 동시 사용
// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"

//위의 코드에서 customerProvider 인자로 전달된 클로저를 호출하는 대신에 collectCustomerProviders(_:) 함수는 클로저를 customerProviders 배열에 추가합니다. 이 배열은 함수의 범위 밖에 선언됩니다. 이것은 배열에 클로저는 함수가 반환된 후에 실행될 수 있다는 의미입니다. 그 결과 customerProvider 인자의 값은 함수의 범위를 벗어날 수 있어야 합니다.


func autoTest(content: @autoclosure ()->()){
    content()
}

autoTest(content: print("권일근"))

func noAutoClosure(handler: ()->()) {
    handler()
}

noAutoClosure {
    print("박선미")
}
