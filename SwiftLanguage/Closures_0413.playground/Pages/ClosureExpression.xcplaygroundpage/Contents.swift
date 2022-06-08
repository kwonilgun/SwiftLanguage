//: [Previous](@previous)

import Foundation

//‘Nested functions are closures that have a name and can capture values from their enclosing function.
//Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.’

//‘Closure expressions are a way to write inline closures in a brief, focused syntax. Closure expressions provide several syntax optimizations for writing closures in a shortened form without loss of clarity or intent. The closure expression examples below illustrate these optimizations by refining a single example of the sorted(by:) method over several iterations, each of which expresses the same functionality in a more succinct way.’


//소팅할 리스트
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

print(reversedNames)

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 < s2
})

print(reversedNames)

//💇‍♀️Inferring Type From Context: 문맥으로부터 추론하기💇‍♀️
//‘Because the sorting closure is passed as an argument to a method, Swift can infer the types of its parameters and the type of the value it returns.
//스위프트는 파라미터와 리턴 값의 타입으로부터 추론을 한다.

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

//후행 클러저는 by: 를 생략할 수 있다.
var anotherSort = names.sorted { s1, s2 in s1 < s2}
anotherSort = names.sorted(by: { $0 > $1 })

print(anotherSort)


