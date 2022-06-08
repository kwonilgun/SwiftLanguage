//: [Previous](@previous)

import Foundation

enum NumberError: Error {
case negativeNumber
    case evenNumber
}

func isOddNumber(number: Int) throws -> Int {
    guard number >= 0 else {
        throw NumberError.negativeNumber
    }
    guard !number.isMultiple(of: 2) else {
        throw NumberError.evenNumber
    }
    return number
}

let result = Result {
    try isOddNumber(number: 2)
}

switch result {
case .success(let data) :
    print(data)
case .failure(let error):
    print(error)
}


enum ResultGen<P, V> {
    case success(P)
    case failure(V)
    
    
}

var value: ResultGen<Int, String> = .success(5)
var string: ResultGen<Int, String> = .failure("실패")
print(value)


let resultValue = Result {
    5
}

print(resultValue)
