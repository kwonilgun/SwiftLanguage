import UIKit

var greeting = "Hello, playground"

//‘Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. You use the self property to refer to the current instance within its own instance methods.’

//모든 인스턴스는 self 라고 불리는 암묵적인 프로퍼티를 가지고 있다. 인스턴스 자신을 나타내는. 인스턴스 메소드 내에서 현재의 인스턴스를 가르키는 self property를 사용한다.

//self는 메소드 내에서 현재의 인스턴스를 가르킨다.

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
