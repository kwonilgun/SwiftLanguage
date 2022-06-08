//: [Previous](@previous)

import Foundation

struct User {
    let name: String
}

let users = [
    User(name: "John"),
    User(name: "Alice"),
    User(name: "Bob")
]

let userNames = users.map { user in
    return user.name
}

print(userNames)


//Value는 제네릭이고 String에 해당한다. Element는 User 에 해당되는 것이다. 
extension Array {
    func map<Value>(path keyPath: KeyPath<Element, Value>) -> [Value] {
        print("map KVC")
        //return map { $0[keyPath: keyPath] }
        return map { s0 in return s0[keyPath: keyPath]}
    }
}

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}

//That’s pretty cool, but where key paths really start to shine is when they’re used to form slightly more complex expressions, such as when sorting a sequence of values.

//The standard library is able to automatically sort any sequence containing Sortable elements, but for all other types we have to supply our own sorting closure. However, using key paths, we can easily add support for sorting any sequence based on a key path for a Comparable value. Just like before, we’ll add an extension on Sequence that converts a given key path into a sorting expression closure:

let userName2 = users.map(path: \.name)
print(userName2)


//users를 keyPath를 이용해서 소팅을 한다. 구조체를 소팅ㅇㄹ 한다.
let sortedUsers = users.sorted(by: \.name)
print(type(of: sortedUsers))
for user in sortedUsers {
    print(user.name, terminator: " ")
}
