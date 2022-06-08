//: [Previous](@previous)

import Foundation
import Darwin


//이것으로 Collection 타입은 Int array 를 return 할 수 있고, String Array를 리턴할 수 있다.  타입은 여러가지 올 수 없다
func getData() -> some Collection {
    return Bool.random() ? [1,2,3] : ["Hello", "World"]
}

let data = getData()
print(data)

if let element = data.randomElement() as? Int {
    print(element)
}
else {
    print("Int가 아니다. ")
}

func getOneTypeOfValue() -> some Equatable {
    return 0
}

let firstValue = getOneTypeOfValue()
let secondValue = getOneTypeOfValue()

firstValue == secondValue

print(type(of: firstValue))

func getAnotherTypeOfValue() -> some Equatable {
    return "0"
}

let thirdValue = getAnotherTypeOfValue()
print(type(of: thirdValue))


//이것은 에러가 발생이 된다.
//Cannot convert value of type 'some Equatable' (result of 'getAnotherTypeOfValue()') to expected argument type 'some Equatable' (result of 'getOneTypeOfValue()')
//firstValue == thirdValue
