//: [Previous](@previous)

import Foundation

//함수나 메서드는 rethrows키워드를 사용하여 자신의 매개변수로 전달받은 함수가 오류를 던진다는 것을 나타낼 수 있습니다.
//최소 하나 이상의 오류 발생 가능한 함수를 매개변수로 전달받아야합니다.

enum MyError: Error {
    case cannotDivide
    case cannotDivideRethrow
}

func divideNumber(first: Float, second: Float) throws -> Float {
    if second == 0 {
        throw MyError.cannotDivide
    }
    return first/second
}

//func calculateFunction(function: (Float, Float) -> Float) {
//    print(function(2, 3))
//}

//에러가 발생을 하면 한번 더 그 에러를 던진다. 즉 rethrow 한다. 
func calculateFunction(function: (Float, Float) throws -> Float) rethrows {

//    do {
//        try function(2, 0)
//    }
//    catch {
//        throw MyError.cannotDivideRethrow
//    }
    
    let someThing = try function(2, 0)
    print(someThing)
}

do {
     try calculateFunction(function: divideNumber)
    
} catch let error as MyError {
    switch error {
    case .cannotDivide:
         print("0으로 나누었다.")
    case .cannotDivideRethrow:
        print("다시 0 이다. ")
    }
}

