import SwiftUI

//불투명한 반환 타입이 있는 함수 또는 메서드는 반환값의 타입 정보를 가립니다. 함수의 반환 타입으로 구체적인 타입을 제공하는 대신에 반환값은 지원되는 프로토콜 측면에서 설명됩니다. 반환값의 기본 타입이 비공개로 유지될 수 있으므로 모듈과 모듈을 호출하는 코드 사이의 경계에서 타입 정보를 숨기는 것이 유용합니다. 타입이 프로토콜 타입 인 값을 반환하는 것과 달리 불투명한 타입은 타입 정체성을 보존합니다—컴파일러는 타입 정보에 접근할 수 있지만 모듈의 클라이언트는 그럴 수 없습니다.

//‘A function or method with an opaque return type hides its return value’s type information. Instead of providing a concrete type as the function’s return type, the return value is described in terms of the protocols it supports. Hiding type information is useful at boundaries between a module and code that calls into the module, because the underlying type of the return value can remain private. Unlike returning a value whose type is a protocol type, opaque types preserve type identity—the compiler has access to the type information, but clients of the module don’t.’

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
print(joinedTriangles.draw())


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
print(middle.draw())


//Shape 프로토콜을 준수하는 한 어떤 타입도 반환할 수가 있다.
//리턴 타입의 변경없이 다양한 방법으로 trapezoid 를 그릴 수 있다.
//Triangle, Square, FlippedShape, trapezoid 도 모두 Shape 프로토콜을 준수한다.
//some은 함수에서 그것이 리턴하는 타입을 결정한다. Shape을 준수하는 많이 타입의 값이 존재한다.

//The makeTrapezoid() function in this example declares its return type as some Shape; as a result, the function returns a value of some given type that conforms to the Shape protocol, without specifying any particular concrete type. Writing makeTrapezoid() this way lets it express the fundamental aspect of its public interface—the value it returns is a shape—without making the specific types that the shape is made from a part of its public interface. This implementation uses two triangles and a square, but the function could be rewritten to draw a trapezoid in a variety of other ways without changing its return type.
//이 예제의 makeTrapezoid() 함수는 반환 유형을 일부 Shape로 선언합니다; 결과적으로, 함수는 특정 구체적인 유형을 지정하지 않고 Shape 프로토콜을 준수하는 일부 주어진 유형의 값을 반환합니다. makeTrapezoid()를 이렇게 작성하면 공개 인터페이스의 일부로 만들어진 특정 유형을 만들지 않고도 공개 인터페이스의 기본 측면을 표현할 수 있습니다. 반환하는 값은 모양입니다. 이 구현은 두 개의 삼각형과 사각형을 사용하지만, 이 함수는 반환 유형을 변경하지 않고 다양한 방법으로 사다리꼴을 그리기 위해 다시 작성할 수 있다.
//이 예제는 불투명한 반환 유형이 일반 유형의 반대와 같은 방식을 강조합니다. makeTrapezoid() 내부의 코드는 호출 코드가 제네릭 함수에 대해 하는 것처럼 Shape 프로토콜을 준수하는 한 필요한 모든 타입을 반환할 수 있습니다. 함수를 호출하는 코드는 제네릭 함수의 구현과 같은 일반적인 방식으로 작성해야 하며, makeTrapezoid()가 반환하는 모든 Shape 값으로 작동할 수 있습니다.

//함수의 반환 타입을 가릴 수 있다. 불분명하게 만들수 있다.

//여기서 shape는 protocol 이다. 리턴은 실제적으로 타입이 리턴이 된다. 실제적인 struct 즉 타입이 리턴이 된다. 타입을 표시하는 것이 아니고 프로토콜을 나타내는 것이다.
//💇‍♀️-> 이것의 의미를 다시 해석해 보면, bottom의 타입은 FlippedShaped<Triangle> 이고, 리턴 타입이 될 수 있다. trapezoid의 타입은 JoinedShape<Triangle, FlippedShaped<Triangle> 이다. 이것은 타입이다. 여기서 some Shape는 프로토콜이지 타입이 아니다. 이 프로토콜을 준수는 하는 어떤 타입이 리턴이 될 수 있다는 것으로 해석이 되면 된다. 2022년 4월 25일

func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    print(type(of: middle))
    print(type(of: bottom))
    print(type(of: trapezoid))
//    return trapezoid
    //인스턴스를 리턴한다. 이 인스턴스는 타입을 가지고 있다.
    return bottom
}
let trapezoid = makeTrapezoid() //as? FlippedShape<Triangle>


//print(trapezoid?.draw() ?? "nil")


func flip<T: Shape>(_ shape: T) ->  some Shape {
    
    //이것을 구조체이다. 이 구조체은 Shape protocol을 준수한다.
    return FlippedShape(shape: shape)
}

func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    
    //💇‍♀️💇‍♀️💇‍♀️구조체이다. 이 구조체도 Shape protocol을 준수한다. some Shape의 의미는 Shape 프로토콜을 준수하는 어떤 타입도 반환이 가능하다는 뜻이다. 즉 인스턴스를 리턴한다. 이 인스턴스의 타입은
    return JoinedShape(top: top, bottom: bottom)
}

let flipRect = flip(rect)
print("flipRect 타입:\(type(of: flipRect))")

print("smallTriangle:\(type(of: smallTriangle))")
let small = flip(smallTriangle)
print("small type: \(type(of: small))")

let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
//
//print("opaqueJoined.. type:\(type(of:opaqueJoinedTriangles))")
//print(opaqueJoinedTriangles.draw())


//💇‍♀️💇‍♀️flip(_:) 과 join(_:_:) 은 불투명한 반환 타입으로 반환하는 제너릭 모양 연산자인 기본 타입을 래핑하여 해당 타입이 표시되지 않도록 합니다. 두 함수는 의존하는 타입이 제너릭이고 함수에 대한 타입 파라미터가 FlippedShape 와 JoinedShape 에 필요한 타입 정보를 전달하기 때문에 모두 제너릭입니다.


//리턴이 여러군데 있는 경우 불투명 리턴 타입을 가지는 함수는 같은 타입을 가져한다. 다른 타입을 가지면 안된다.
func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
    if shape is Square {
            //return JoinedShape(top: shape, bottom: shape)
            //return shape // Error: return types don't match
        //return FlippedShape(shape: shape)
        }
    return FlippedShape(shape: shape) // Error: return types don't match
}
//‘If a function with an opaque return type returns from multiple places, all of the possible return values must have the same type. For a generic function, that return type can use the function’s generic type parameters, but it must still be a single type. For example, here’s an invalid version of the shape-flipping function that includes a special case for squares:
//불투명한 반환 유형을 가진 함수가 여러 곳에서 반환되는 경우, 가능한 모든 반환 값은 동일한 유형을 가져야 합니다. 제네릭 함수의 경우, 반환 유형은 함수의 제네릭 유형 매개 변수를 사용할 수 있지만, 여전히 단일 유형이어야 합니다. 예를 들어, 다음은 사각형에 대한 특별한 경우를 포함하는 모양 뒤집기 함수의 유효하지 않은 버전입니다:

func rep <T: Shape>(shape: T, count: Int) -> some Collection {
    return Array<T>(repeating: shape, count: count)
}


let data = rep(shape: smallTriangle, count: 3)

print(type(of: data))

for value in data {
    if let val = value as? Shape {
        print(val.draw())
    }
    
}

let data_1 = data.randomElement() as? Shape
if let data = data_1 {
    print(data.draw())
}


//‘In this case, the underlying type of the return value varies depending on T: Whatever shape is passed it, repeat(shape:count:) creates and returns an array of that shape. Nevertheless, the return value always has the same underlying type of [T], so it follows the requirement that functions with opaque return types must return values of only a single type.


func protoFlip<T: Shape>(_ shape: T) -> Shape {
    if shape is Square {
        return shape
    }

    return FlippedShape(shape: shape)
}


let proto = protoFlip(smallTriangle)
print(type(of: proto))

//‘Differences Between Opaque Types and Protocol Types
//Returning an opaque type looks very similar to using a protocol type as the return type of a function, but these two kinds of return type differ in whether they preserve type identity. An opaque type refers to one specific type, although the caller of the function isn’t able to see which type; a protocol type can refer to any type that conforms to the protocol. Generally speaking, protocol types give you more flexibility about the underlying types of the values they store, and opaque types let you make stronger guarantees about those underlying types.
//For example, here’s a version of flip(_:) that uses a protocol type as its return type instead of an opaque return type:’
//불투명한 유형을 반환하는 것은 프로토콜 유형을 함수의 반환 유형으로 사용하는 것과 매우 유사해 보이지만, 이 두 종류의 반환 유형은 유형 ID를 보존하는지 여부와 다릅니다. 불투명한 유형은 하나의 특정 유형을 나타내지만, 함수의 호출자는 어떤 유형을 볼 수 없습니다; 프로토콜 유형은 프로토콜을 준수하는 모든 유형을 참조할 수 있습니다. 일반적으로 프로토콜 유형은 저장하는 값의 기본 유형에 대해 더 많은 유연성을 제공하며, 불투명한 유형을 사용하면 이러한 기본 유형에 대해 더 강력하게 보장할 수 있습니다.

let protoFlippedTriangle = protoFlip(smallTriangle)
print(type(of: protoFlippedTriangle))
let sameThing = protoFlip(middle)
print(type(of: sameThing))

