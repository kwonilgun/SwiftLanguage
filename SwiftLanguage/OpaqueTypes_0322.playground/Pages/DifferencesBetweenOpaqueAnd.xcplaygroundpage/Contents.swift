//: [Previous](@previous)
//Differences Between Opaque Types and Protocol Types
//Returning an opaque type looks very similar to using a protocol type as the return type of a function, but these two kinds of return type differ in whether they preserve type identity. An opaque type refers to one specific type, although the caller of the function isn’t able to see which type; a protocol type can refer to any type that conforms to the protocol. Generally speaking, protocol types give you more flexibility about the underlying types of the values they store, and opaque types let you make stronger guarantees about those underlying types.’
//opaque는 특정한 타입을 가지고 있는 반면, 프로토콜은 특정 타입을 지정하지는 않는다. 좀더 플렉시블하다.

import Foundation

protocol Shape {
    func draw() -> String
}

struct Rect: Shape {
    var name: String
    func draw() -> String {
        return self.name
    }
}

let rect = Rect(name: "Kwon")

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}
let smallTriangle = Triangle(size: 4)

//print(smallTriangle.draw())

//💇‍♀️-> 이 부분을 잘 봐야 한다. 여기서 구조체의 제네릭을 나타내는 것이다. T는 플레이스 홀드이고, 이것의 타입은 Shape 이다. 함수가 아니다. 구조체를 초기화하는 것으로 자연스럽게 Shape 타입이 들어와야 한다.

struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        
        if shape is Square {
            return shape.draw()
        }
        
        let lines = shape.draw().split(separator: "\n")
        //print(lines)
        return lines.reversed().joined(separator: "\n")
    }
}
let flippedTriangle = FlippedShape(shape: smallTriangle)

//print(flippedTriangle.draw())


// 구조체의 제네릭 타입이다.  T, U의 타입은 Shape 이다.
struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}

//joinedTriangles의 타입을 알 수가 있다. 구조체를 인스턴스화 함으로써 정확한 타입을 알수가 있다.
let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
//print(joinedTriangles.draw())


//모양 생성에 대한 자세한 내용을 표출하면 전체 반환 타입을 명시해야 하므로 ASCII 그림 모듈의 공개 인터페이스에 포함되지 않은 타입이 유출될 수 있습니다. 모듈내에 코드는 다양한 방법으로 같은 모양을 구축할 수 있으며 모양을 사용하는 모듈 바깥에서의 다른 코드는 변환 목록에 대한 세부 구현 정보를 고려할 필요가 없습니다. JoinedShape 와 FlippedShape 와 같은 래퍼 타입은 모듈의 사용자에게 중요하지 않으며 표시되지 않아야 합니다. 모듈의 공개 인터페이스는 모양을 결합하고 뒤집는 것과 같은 작업으로 구성되며 이러한 작업은 다른 Shape 값을 반환합니다.

struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        print("line:\(line)")
        let result = Array<String>(repeating: line, count: size)
        print("result:\(result)")
        return result.joined(separator: "\n")
        
    }
}

let middle = Square(size: 2)
//print(middle.draw())

//func protoFlip<T: Shape>(_ shape: T) ->some Shape {
//    if shape is Square {
//        return shape    //Error: return types don't match
//    }
//
//    return FlippedShape(shape: shape)
//}

func protoFlip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}
//: [Next](@next)
