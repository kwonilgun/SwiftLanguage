import Foundation
import Darwin


//11.1.5: 기본 이니셜라이저와 멤버와이즈 이니셜라이져
//사용자 정의 이니셜라이저를 정의해 주기 않으면 클래스나 구조체는 모든 프로퍼티에 기본값이 지정되어 있다는 전제하에 기본 이니셜라이저를 사용한다. 기본 이니셜라이저는 프로퍼티 기본값으로 프로퍼티를 초기화해서 인스턴스를 생성한다. 기본 이니셜라이저는 저장 프로퍼티의 기본값이 모두 지정되어 있고, 동시에 사용자 정의 이니셜라이저가 정의되어 있지 않는 상태에서 제공

struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}


//21.3.3 이니셜라이저

struct Rect {
    var origin: Point = Point()
    var size: Size = Size()
}

let defaultRect: Rect = Rect()
let memberwiseRect: Rect = Rect(origin: Point(x: 2.0, y:2.0), size: Size(width: 5.0, height: 5.0))
dump(memberwiseRect)

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 2.0, height: 2.0))

dump(centerRect)



//11.1.6 초기화 위임
//값 타입인 구조체와 열거형은 코드의 중복을 피하기 위해여 이니셜라이저가 다른 이니셜라이저에게 일부 초기화를 위임하는 초기화 위임을 간단하게 구현할 수 있다.
//값 타입에서 이니셜라이저가 다른 이니셜라이저를 호출하려면 self.init을 사용한다.



enum Student {
    case elementary, middle, high
    case none
    
    
    //사용자 정의 이니셜라이즈가 있는 경우, init() 메서드를 구현해주어야 한다. 기본 이니셜라이저를 사용할 수 있다.
    init() {
        self = .none
    }
    
    init(koreanAge: Int) {
        switch koreanAge {
        case 8...13:
            self = .elementary
        case 14...16:
            self = .middle
        default:
            self = .none
        }
    }
    
    init(bornAt: Int, currentYear: Int) {
        self.init(koreanAge: currentYear - bornAt + 1)
    }
}

var younger: Student = Student(koreanAge: 16)
print(younger)

younger = Student(bornAt: 1998, currentYear: 2010)
print(younger)
