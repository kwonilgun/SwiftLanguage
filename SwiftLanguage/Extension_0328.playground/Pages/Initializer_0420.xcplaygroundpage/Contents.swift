//: [Previous](@previous)

import Foundation


//Extensions can add new initializers to existing types. This enables you to extend other types to accept your own custom types as initializer parameters, or to provide additional initialization options that were not included as part of the type’s original implementation.
//Extensions can add new convenience initializers to a class, but they can’t add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.’

//If you use an extension to add an initializer to a value type that provides default values for all of its stored properties and doesn’t define any custom initializers, you can call the default initializer and memberwise initializer for that value type from within your extension’s initializer. This wouldn’t be the case if you had written the initializer as part of the value type’s original implementation, as described in Initializer Delegation for Value Types.
//Extensions는 새로운 이니셜라이저를 추가할 수 있다. 초기화 파라미터로 당신 자신의 커스텀 타입을 받아들이도록 확대할 수 있다. 커스텀 파라미터를 만들 수 있다.

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
   size: Size(width: 5.0, height: 5.0))


extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x:originX, y:originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))

dump(centerRect)
