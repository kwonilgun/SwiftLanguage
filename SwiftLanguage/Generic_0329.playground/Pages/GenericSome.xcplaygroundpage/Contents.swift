import UIKit

/*
 -코드에서 placeholder T 를 사용하고 있으며, a,b 파라미터 모두 타입이 T 입니다. 또한 함수는 T 타입의 값을 리턴하고 있습니다. 그리고 T 타입은 Numeric 프로토콜을 준수해야 하는 것을 알 수 있습니다.
 
 -그 결과 이 함수는 integer, double 값등이 들어갈 수 있습니다.
 -placeholder인 T는 말그대로 자리를 맡아주는 역할입니다. 코드가 컴파일 될 때, Swift는 이것을 Int나 Double같은 정확한 타입으로 대체합니다.
 -호출자가 T의 기본 유형을 알고 있기 때문에 placeholder가 투명하다고 말할 수 있습니다.
 -제네릭 타입의 경우에는 함수를 구현하는 내부에서는 타입을 숨기다가 이 함수를 사용할 때 어떤 타입이 들어가는지 알 수 있습니다.
 */
func addition<T: Numeric>(a: T, b: T) -> T {
    return a + b
}

let resultA = addition(a: 42, b: 99)
let resultB = addition(a: 3.1415, b: 1.618)

print(resultA)
print(resultB)

//some : 불투명한 타입이 무엇인지 알아 보겠다.
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

func makeShape() -> Shape {
    let circle: Circle = Circle()
    return circle;
}

let shape = makeShape()
print(shape.describe())
/*
 var body: some View {
       //코드내용
 }
 
 위 코드의 의미는 View 프로토콜을 준수하는 모든 타입의 결과가 반환될 수 있다는 말이다.
 
 wiftUI에서 눈에 띄는 키워드 some.
 이 some은 opaque 리턴 타입을 선언할 수 있게 해준다.
 generic protocol도 리턴 타입으로 사용될 수 있다.
 some은 당장 SwiftUI의 body에서 사용된다.
 struct ContentView: View {
     var body: some View {
         Text("Hello, world!")
     }
 }
 some이 없었다면, 아래와 같이 특정 View 타입을 지정해주거나
 struct ContentView: View {
     var body: Text {
         Text("Hello, world!")
     }
 }
 AnyView를 사용해 타입을 지워야한다.
 그러면 리턴할때마다 타입을 다음과 같이 지워야한다.
 struct ContentView: View {
     var body: AnyView {
         AnyView(Text("Hello, world!"))
     }
 }
 return 생략

 단일 표현 함수는 return 키워드를 생략할 수 있다.
 아래의 두 코드는 동일하게 작동한다.
 struct ContentView: View {
     var body: some View {
         return Text("Hello, world!")
     }
 }

 struct ContentView: View {
     var body: some View {
         Text("Hello, world!")
     }
 }
 */

func someList() -> [Int] {
    
    return [1,2,3]
}

func someList1() -> some Collection {
    return [4,5,6,7]
}



let list = someList()
print(list)
let list1 = someList1()
print(list1)

