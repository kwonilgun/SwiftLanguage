//: [Previous](@previous)
//πββοΈπββοΈ -> νλ‘ν μ½μ λ€μ΄ μΊμ€νμ΄ μ€λͺνλ μμ μ΄λ€. μ λ³Όνμκ° μλ€.
//βyou can use protocols as a fully fledged types in your code. Using a protocol as a type is sometimes called an existential type, which comes from the phrase βthere exists a type T such that T conforms to the protocolβ.

//νλ‘ν μ½μ μ€μνλ νμ Tκ° μ‘΄μ¬λ₯Ό νλ€.νλ‘ν μ½μ νμμΌλ‘ μ΄μ©νλ κ²μ μ‘΄μ¬μ μ νμ΄λΌκ³  νλ€.
//νλ‘ν μ½μ νμμΌλ‘ μ΄μ©νλ κ²μ existential type μ΄λΌκ³  λΆλ₯Έλ€.

//νλ‘ν μ½μ νμμΌλ‘ μ΄μ©νλ κ²½μ°
//1. ν¨μ, λ©μλ , μ΄κΈ°νμμ λ¦¬ν΄ νμκ³Ό νλΌλ―Έν° νμμΌλ‘ μ΄μ©
//2. constant, variable or properyμ νμμ μ μ©
//3. array. dictionary or other container νμμ μ μ©

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
    let generator: RandomNumberGenerator    //νλ‘ν μ½μ΄ νμμΌλ‘ μ΄μ©λμλ€.
    
    init(sides: Int, generator: RandomNumberGenerator) {  //νλ‘ν μ½μ΄ νμμΌλ‘ μ΄μ©λμλ€. νμμΊμ€νμ΄ μμ°μ€λ‘­κ² λ°μνλ€.
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



//ν΄λμ€μ μΈμ€ν΄κ° μμ±λμκ³ 
var generate = LinearCongruentialGenerator()

//generateμ νλ‘νΌν°κ° μ΄κΈ°νλμκΈ° λλ¬Έμ κ°μ κ°κ³ 
print(generate.a)
print(generate.random())


//μΈμ€ν΄μ€μ downcastingμ΄ μΌμ΄λλ€. μ΄ νλ‘ν μ½μ μ€μνλ κ²λ§μ΄ μ‘΄μ¬
var gen = LinearCongruentialGenerator() as RandomNumberGenerator
print(gen.random())


//πββοΈπββοΈ -> μ΄λΆλΆμμ μ νμμ ν΄μΌ νλ€. generatorμ νμμ νλ‘ν μ½ RandomNumberGenerator μ΄λ€. LinerCongruentialGenerator() ν΄λμ€μ μΈμ€ν΄μ€κ° λμκ³  μ΄κ²μ λν΄μ νλ‘ν μ½μ λ€μ΄ μΊμ€νμ΄ μΌμ΄λλ€.


var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}
