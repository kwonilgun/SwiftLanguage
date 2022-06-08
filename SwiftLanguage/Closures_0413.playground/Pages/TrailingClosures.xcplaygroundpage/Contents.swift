//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//‘Trailing Closures
//If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. You write a trailing closure after the function call’s parentheses, even though the trailing closure is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the first closure as part of the function call. A function call can include multiple trailing closures; however, the first few examples below use a single trailing closure.’

//💇‍♀️후행클러저 -> argument label 이 필요없다.

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}


//소팅할 리스트
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
var reversedNames = names.sorted() { $0 > $1 }
reversedNames = names.sorted { $0 < $1 }
