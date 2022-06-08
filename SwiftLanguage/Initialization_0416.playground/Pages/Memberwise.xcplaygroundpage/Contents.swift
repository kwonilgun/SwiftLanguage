

//Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don't have default values.
//기본값을 가지고 있지 않아도 멤버와이즈 이니셜라이저를 받는다. 

import Foundation

struct Size {
    var width :Double
    var height :Double
}

let twoByTwo = Size(width: 10.0, height: 10.0)

print(twoByTwo)
