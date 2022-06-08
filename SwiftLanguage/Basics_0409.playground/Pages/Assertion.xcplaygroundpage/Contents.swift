//: [Previous](@previous)

import Foundation

//‘Assertions and preconditions are checks that happen at runtime. You use them to make sure an essential condition is satisfied before executing any further code. If the Boolean condition in the assertion or precondition evaluates to true, code execution continues as usual. If the condition evaluates to false, the current state of the program is invalid; code execution ends, and your app is terminated.

//Assertion과 precondition들은 런타임 중에 발생하는 체크이다. 추가적인 코드를 실행하지 전에 기본적인 조건이 만족하는 지를 확인하기 위해서 사용된다. 조건이 맞으면 추가적인 실행이 되고, 조건이 맞지 않으면 코드의 실행이 중단된다.


//Assertions help you find mistakes and incorrect assumptions during development, and preconditions help you detect issues in production.’

//Assertion은 개발 중에 잘못을 찾아내는 것이고, preconditions는 생산 코드에서 문제를 검출한다.


//Unlike the error conditions discussed in Error Handling above, assertions and preconditions aren’t used for recoverable or expected errors. Because a failed assertion or precondition indicates an invalid program state, there’s no way to catch a failed assertion.


//let age = -3
let age = 3
assert(age >= 0, "A person's age can't be less than zero.")
// This assertion fails because -3 isn't >= 0.

//If the code already checks the condition, you use the assertionFailure(_:file:line:) [https://developer.apple.com/documentation/swift/1539616-assertionfailure] function to indicate that an assertion has failed. For example:

if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can ride the ferris wheel.")
} else {
    //조건을 체크할 필요가 없다.
    assertionFailure("A person's age can't be less than zero.")
}
