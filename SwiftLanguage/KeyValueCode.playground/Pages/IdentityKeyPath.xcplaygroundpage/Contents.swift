

import Foundation

//Identity Key Path

//We also have a special path that can refer to a whole instance instead of a property. We can create one with the following syntax, \.self.

//프로퍼티 대신에 전체 인스턴스를 참조하는 specical path 이다.

//The result of the identity key path is the WritableKeyPath of the whole instance, so you can use it to access and change all of the data stored in a variable in a single step.

//https://sarunw.com/posts/what-is-keypath-in-swift

var foo = "Foo"

let stringIdentity = \String.self
//WritableKeyPath<String, String>
//이것은 self가 전체 String을 가르킨다. Idenity key path 이다.

foo[keyPath: stringIdentity] = "바보"  //자기 자신을 가르킨다.
print(foo)


struct User {
  let name: String
}
var user = User(name: "John")

// 2  Identity Key path 이다. subscript처럼 동작을 한다.
let userIdentity = \User.self
// WritableKeyPath<User, User>

user[keyPath: userIdentity] = User(name: "Doe")
print(user) // User(name: "Doe")
