//: [Previous](@previous)
//💇‍♀️💇‍♀️ -> 프로토콜의 다운 캐스팅이 설명하는 예제이다. 잘 볼필요가 있다.
//‘you can use protocols as a fully fledged types in your code. Using a protocol as a type is sometimes called an existential type, which comes from the phrase “there exists a type T such that T conforms to the protocol”.

//프로토콜을 준수하는 타입 T가 존재를 한다.프로토콜을 타입으로 이용하는 것을 존재의 유형이라고 한다.
//프로토콜을 타입으로 이용하는 것을 existential type 이라고 부른다.

//프로토콜을 타입으로 이용하는 경우
//1. 함수, 메소드 , 초기화에서 리턴 타입과 파라미터 타입으로 이용
//2. constant, variable or propery의 타입에 적용
//3. array. dictionary or other container 타입에 적용

import Foundation

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator    //프로토콜이 타입으로 이용되었다.
    
    init(sides: Int, generator: RandomNumberGenerator) {  //프로토콜이 타입으로 이용되었다. 타입캐스팅이 자연스롭게 발생한다.
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}



var d7 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d7.roll())")
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"

print(generator.lastRandom)
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283



//클래스의 인스턴가 생성되었고
var generate = LinearCongruentialGenerator()

//generate의 프로퍼티가 초기화되었기 때문에 값을 갖고
print(generate.a)
print(generate.random())


//인스턴스의 downcasting이 일어난다. 이 프로토콜에 준수하는 것만이 존재
var gen = LinearCongruentialGenerator() as RandomNumberGenerator
print(gen.random())


//💇‍♀️💇‍♀️ -> 이부분에서 잘 파악을 해야 한다. generator의 타입은 프로토콜 RandomNumberGenerator 이다. LinerCongruentialGenerator() 클래스의 인스턴스가 되었고 이것에 대해서 프로토콜의 다운 캐스팅이 일어난다.


var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}
