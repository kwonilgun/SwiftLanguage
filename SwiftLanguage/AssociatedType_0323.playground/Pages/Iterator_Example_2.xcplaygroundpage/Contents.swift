//: [Previous](@previous)

import Foundation

/// Conforming to the Sequence Protocol
/// ===================================
///
/// Making your own custom types conform to `Sequence` enables many useful
/// operations, like `for`-`in` looping and the `contains` method, without
/// much effort. To add `Sequence` conformance to your own custom type, add a
/// `makeIterator()` method that returns an iterator.
///
/// Alternatively, if your type can act as its own iterator, implementing the
/// requirements of the `IteratorProtocol` protocol and declaring conformance
/// to both `Sequence` and `IteratorProtocol` are sufficient.
///
/// Here's a definition of a `Countdown` sequence that serves as its own
/// iterator. The `makeIterator()` method is provided as a default
/// implementation.
///
struct Countdown: Sequence, IteratorProtocol {
        
        typealias Element = Int
    
        var count: Int

         mutating func next() -> Element? {
             if count == 0 {
                 return nil
             } else {
                 defer { count -= 1 }
                 return count 
             }
         }
     }

let threeToGo = Countdown(count: 3)
for i in threeToGo {
    print(i)
}
// Prints "3"
// Prints "2"
// Prints "1"

print("\n=============")

var fiveToGo = Countdown(count: 5)

while let data = fiveToGo.next() {
    print(data, terminator: " ")
}
print("\n=============")
/// Expected Performance
/// ====================
///
/// A sequence should provide its iterator in O(1). The `Sequence` protocol
/// makes no other requirements about element access, so routines that
/// traverse a sequence should be considered O(*n*) unless documented
/// otherwise.


struct SomeSequence: Sequence {
    var count: Int
    func makeIterator() -> ModelIterate {
        return ModelIterate(count: self.count)
        }
}


struct ModelIterate: Sequence, IteratorProtocol {
    var count: Int
    
    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}


let sequences = SomeSequence(count: 6)
var data = sequences.makeIterator()

sequences.forEach { s1 in
    print("\(s1)-", terminator: "")
}
print("\n")
let drop = sequences.dropFirst(2)
print(drop)
for data in drop {
    print(data, terminator: " ")
}

print("\n==========")
let enumerate = sequences.enumerated()
for (key, value) in enumerate {
    print(key,value, terminator: " = ")
}

for arr in sequences {
    print(arr,terminator: " ")
}


let seq = sequences.first { s1 in
    if(s1 == 3) {
        return true
    }
    else {
        return false
    }
}

if let first = seq {
    print("first = \(first)")
}


let prefix = sequences.prefix(2)
//print("prefix:\(prefix)")
let suffix = sequences.suffix(2)

for data in prefix {
    print(data, terminator: " ")
}

print("\n=========")
for data in suffix {
    print(data, terminator: " ")
}

if let min = sequences.min() {
    print("minum: \(min)")
}

if let max = sequences.max() {
    print("maximum:\(max)")
}

for data in sequences {
    print(data)
}

print(" ")
print("--------------")
while let value = data.next() {
    print(value, terminator: " ")
}


let sequences_1 = SomeSequence(count: 5)
data = sequences_1.makeIterator()
print(" ")
print("--------------")
for i in data {
    print(i, terminator: " ")
}


//struct AnySequence: Sequence {
//    var count: Int
//
//    func makeIterator() -> some IteratorProtocol {
//        return ModelIterate(count: self.count)
//    }
//
//}
//
//let any_1 = AnySequence(count: 6)
//data = any_1.makeIterator()


