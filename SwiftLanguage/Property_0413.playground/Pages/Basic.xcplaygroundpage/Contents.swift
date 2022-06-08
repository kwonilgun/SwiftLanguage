//: [Previous](@previous)

import Foundation

//프로퍼티와 메소드
//프로퍼티는 클래스, 구조체 또는 열거형 등에 관련된 값, 메서드는 특정 타입에 관련된 함수를 뜻한다.
//저장 프로퍼티, 연산 프로퍼티, 타입 프로퍼티
//저장 프로퍼티는 인스턴스의 변수 또는 상수를 의미한다.
//연산 프로퍼티는 값을 저장하는 것이 아니라 특정 연산 결과값을 의미한다.
//저장, 연산 프로퍼티는 특정 타입의 인스턴스에 사용된다.
//특정 타입에 사용되는 프로퍼티도 존재 타입 프로퍼티이다.


//저장 프로퍼티
//옵셔널 저장 프로퍼티

struct CoordinatePoint {
    var x: Int = 0
    var y: Int = 0
}

class Position {
    var point: CoordinatePoint? //  옵셔널 저장 프로퍼티
    let name: String
    
    init(name: String) {
        self.name = name
    }
}


//이름은 필수지만, 위치는 모를 수 있다. 옵셔널로 지정을 했기 때문에 이니셜라이저에서 위치는 빠져있다.
var position: Position = Position(name: "kwon")

//위치를 알개되면 그 때 위치 값을 할당해 준다. 값 세팅을 늦게 한다. 초기화에서 없어도 된다. 나중에 세팅해 준다.
position.point = CoordinatePoint(x: 20, y: 30)
dump(position)


//지연저장 프로퍼티

class PositionLazy {
    lazy var point: CoordinatePoint = CoordinatePoint(x: 10, y: 20)
    var name: String
    
    init(name: String){
        self.name = name
    }
}

var lazy: PositionLazy = PositionLazy(name: "소진")
print(lazy.point)   //lazy.point가 호출될 때 좌표 지정이 실행이 된다. 함수 실행을 미룬다. 이것이 차이이다


//연산 프로퍼티
class PositionCal {
    
    var point: CoordinatePoint?
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    var opposition: CoordinatePoint{
       get {
//           var temp: CoordinatePoint = CoordinatePoint()
//                       temp.x = -(self.point?.x ?? 0)
//                       temp.y = -(self.point?.y ?? 0)
//            return temp
           
           CoordinatePoint(x: -(self.point?.x ?? 0), y: -(self.point?.y ?? 0))
        }
        
        set {
            self.point?.x = -newValue.x
            self.point?.y = -newValue.y
            
        }
    }
}

var data: PositionCal = PositionCal(name: "선미")
data.point = CoordinatePoint(x: 10, y: 100)

print(data.opposition)

data.opposition = CoordinatePoint(x: 200, y: 300)
dump(data)
print(data.opposition)
