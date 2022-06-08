//: [Previous](@previous)

import Foundation

//제목 -> Adding Constraints to Protocol Extensions
//When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available. You write these constraints after the name of the protocol you’re extending by writing a generic where clause. For more about generic where clauses, see Generic Where Clauses.
//
//For example, you can define an extension to the Collection protocol that applies to any collection whose elements conform to the Equatable protocol. By constraining a collection’s elements to the Equatable protocol, a part of the standard library, you can use the == and != operators to check for equality and inequality between two elements


// Collection에서 Element 제네릭 타입에 Equatable 제약을 두면 표준 라이브러리에 있는 ==, != 이것을 이용할 수 있다.
//결국 self는 콜렉션이다. 이것의 element 가 Equatable을 준수하면  allEqual()을 호촐되면 비교가 자동적으로 된다. 
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let equalNumbers = [100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100]

print(equalNumbers.allEqual())
print(differentNumbers.allEqual())
