//: [Previous](@previous)

import Foundation

//‘In contrast to optionals, which can use the presence or absence of a value to communicate success or failure of a function, error handling allows you to determine the underlying cause of failure, and, if necessary, propagate the error to another part of your program.

//옵셔널->함수의 성공 실패를 값의 존재와 부재를 이용할 수 있다.
//error handling은 실패의 원인을 결정하고 다른 파트에 에러를 전달할 수 있다.

//에러를 던진다.
func canThrowAnError() throws {
    // this function may or may not throw an error
}

do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}
