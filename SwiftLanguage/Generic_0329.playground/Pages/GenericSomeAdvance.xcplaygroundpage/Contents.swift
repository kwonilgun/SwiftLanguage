
//12월 27일 : SomeExample.playground

import UIKit
import Darwin

//And the some keyword that we use here is a switch feature that lets swift infer out inter return type automatically.

//불투명한 타입과 제네릭은 연관이 있습니다. 사실 불투명한 타입은 보통 reverse generic type 이라고 불리기도 합니다.
//제네릭 타입의 플레이스 홀더를 사용하면 함수 호출자가 placeholder의 구체적인 형식을 결정합니다.
//💇‍♀️ -> 불투명한 타입을 사용하면 구현에서 구체적인 유형을 결정하게 됩니다.


//1. Generic
//아래 코드에서 placeholder T 를 사용하고 있으며, a,b 파라미터 모두 타입이 T 입니다. 또한 함수는 T 타입의 값을 리턴하고 있습니다. 그리고 T 타입은 Numeric 프로토콜을 준수해야 하는 것을 알 수 있습니다.
//그 결과 이 함수는 integer, double 값등이 들어갈 수 있습니다.
//placeholder인 T는 말그대로 자리를 맡아주는 역할입니다. 코드가 컴파일 될 때, Swift는 이것을 Int나 Double같은 정확한 타입으로 대체합니다.
//호출자가 T의 기본 유형을 알고 있기 때문에 placeholder가 투명하다고 말할 수 있습니다.
//제네릭 타입의 경우에는 함수를 구현하는 내부에서는 타입을 숨기다가 이 함수를 사용할 때 어떤 타입이 들어가는지 알 수 있습니다.

func addition<T: Numeric>(a: T, b: T) -> T {
    return a + b
}

let resultA = addition(a: 42, b: 99)
let resultB = addition(a: 3.1415, b: 1.618)


//2. some 있던 없던 상관이 없다.
//아래의 코드를 봤을 때 Shape라는 protocol 을 정의하였고 이 프로토콜을 준수하고 있는 구조체가 있습니다.
//만약에 makeShape() 메서드를 다음과 같이 정의해보겠습니다.


//💇‍♀️ -> 중요한 점은 타입 관련된 것이 없다. 이런 경우 protocol은 타입과 무관한다. 이 경우는 some이 의미가 없다. 있어도 되고, 없어도 된다.
protocol Shape {
    func describe() -> String
}

struct Square: Shape {

    func describe() -> String {
            return "I'm a square. My four sides have the same lengths."
        }
    
}

struct Circle: Shape {
    
    func describe() -> String {
        return "I'm a circle. I look like a perfectly round apple pie."
    }
}

//이 makeShape()는 Shape 타입을 리턴합니다. 이때 some 키워드를 사용하여 불투명한 타입을 나타내고 있습니다.
//반환되는 구체적인 타입을 결정하는 것은 함수에게 달려 있습니다. 여기서는 Circle 타입을 반환하게 됩니다.
//제네릭 타입과는 반대로 함수 내부에서는 반환 타입을 정확히 알 수 있지만, 밖에서는 반환값의 타입을 정확히 알지 못하게 숨기는 것입니다.

func makeShape() -> some Shape {
  return Circle()
}

//some 을 제거해도 문제가 없다.
func makeShape_1() ->  Shape {
  return Square()
}

let shape = makeShape()
print(shape.describe())

let shape_1 = makeShape_1()
print(shape_1.describe())


// 2 some을 제거하면 에러가 발생한다.
//Protocols can have associated types. An associated type gives a placeholder name to a type that’s used as part of the protocol. For example, 💇‍♀️ -> Swift’s Collection protocol has an associated type called Element. It corresponds to the type of the elements inside the collection, such as String inside [String] (an array of strings).
//
//Such a placeholder is the same placeholder type as found in generics, so they’re not concrete types – just placeholders. Associated types are useful when you want to define a value in a protocol, but you don’t want to be specific about the type of that value. 💇‍♀️ -> Associated types need to be made concrete by the type that adopts the protocol.
//
//Note: You can learn more about associated types in this tutorial about generics. In it, we’re using a protocol with an associated type to design any kind of storage that can store any kind of item.
//
//Let’s add an associated type to the Shape protocol we’ve used before. Like this:

//What’s happened? We’ve created a Square and a Circle struct, like before, which both adopt the Shape protocol. Both shapes also implement the color property, as required by the protocol. Their types are different, though!
//
//We’ve given the color properties a concrete type:
//
//Square uses a string for color
//Circle uses an integer for color
//For the sake of the example, it’s easiest to imagine at this point that we can describe a color as a string, like “Green”, and as a number, like 255.
//
//Finally, we want to build a function that produces a shape. We don’t care what kind of shape, so we’re using the Shape protocol as its return type. It can return anything that conforms to the Shape protocol.

//💇‍♀️ -> shape를 생성하는 함수를 만들고 싶다. 어떤 형태인지는 관심이 없다. 리턴 타입으로 Shape protocol을 이용하고 있다. shape 형태를 준수하는 어떤 것을 리턴할 수 있다.

//하기와 같은 에러가 발생한다. ShapeSome 프로토콜이 associated type 을 가지고 있기 때문에
//generic 한 리턴이 필요하다는 것이다.

//Protocol 'ShapeSome' can only be used as a generic constraint because it has Self or associated type requirements
/*
func makeShape_some() -> ShapeSome {
    return SquareSome(color: "Yellow")
}
 */
protocol ShapeSome {
    associatedtype Color        //💇‍♀️ -> associatedtype 을 추가했다. 이것이 핵심이다. !!!!!!!
    var color: Color { get }
    func describe() -> String
}

struct TriangleSome: ShapeSome {
    typealias Color = String
    
    var color: Color
    func describe() -> String {
        return("삼각형: " + self.color)
    }
}

struct SquareSome: ShapeSome {
    typealias Color = String
    
    var color: Color
    func describe() -> String {
        return "I'm a square : " + self.color
    }
}

struct CircleSome: ShapeSome {
    typealias Color = Int
    
    var color: Color    //Color는 Integer
    func describe() -> String {
        return "I'm a circle : " + String(self.color)
    }
}



//이와같은 에러를 제거하기 위해서는 Opaque Type 이 필요하다.
func makeShape_some() -> some ShapeSome {
    let result = SquareSome(color: "Yellow")
    return result
}

let shapeSquare = makeShape_some()
print(shapeSquare.describe())


func makeCircle_some() -> some ShapeSome {
    let result = CircleSome(color: 123)
    return result
}

let shapeCircle = makeCircle_some()
print(shapeCircle.describe())

func someShapeReturn(_ choice : Int) -> some ShapeSome {
    
    //이 문제는 리턴 타입이 하나가 되어야 한다.
    switch choice {
        case 1:
              SquareSome(color: "Yellow")
        case 2:
            fallthrough
        
        default:
             CircleSome(color: 150)
    }
    return CircleSome(color: 150)
}

//The some keyword will make the Shape return type opaque. Instead of makeShape() returning any type that conforms to the Shape protocol, it can now return a type that conforms to the Shape protocol – always the same one, but we don’t know which one.

/*
func makeShape() -> Shape { // <-- Swift doesn't know type of `Color` here return Square(color: "Yellow") // <-- it does know type of `Color` here! } Swift can’t be certain that the makeShape() function will always return a Shape of which the associated type is String. For all it knows, the associated type could be Int or Cowbell or Invoice. Unfortunately, the associated type for Shape cannot be determined by “looking into” the function implementation. So, what do we do? We add the some keyword to the function declaration, like this: func makeShape() -> some Shape {
return Square(color: “Yellow”)
}

The some keyword will make the Shape return type opaque. Instead of makeShape() returning any type that conforms to the Shape protocol, it can now return a type that conforms to the Shape protocol – always the same one, but we don’t know which one.

Just as with generic type placeholders, the Shape type is concretized when Swift compiles the code. The concrete type for some Square is Square here, based on the implementation of the function (i.e., code inside function).

Just as with generic placeholder types, we, the developers, get to be generic and opaque about what type we’re returning exactly. It’s always the same type, we just don’t (yet) know which one.

*/


// some은 피 호출자가 타입을 결정한다. Collection 은 Int array 와 String array를 모두 지원을 한다. 
//Collection 프로토콜이 associatetype 을 가지고 있다.
//이 Collection은 [Int] 콜렉션을 리턴한다.
func someList() ->  some Collection {
  return [1,2,3]
}
print(someList())


//이 Collection은 [String] 콜렉션을 리턴한다. 그럼으로 some 이 필요하다.
func someStringList() -> some Collection {
    return ["Hello", "World", "Kwon"]
}
print(someStringList())

//Collection 에 대해서

let numbers = [10,20,30,40]
let startIndex = numbers.startIndex
let endIndex = numbers.endIndex

print(startIndex, endIndex)

let strings = ["Hello", "World", "Kwon"]
let count = strings.count
print(count)
