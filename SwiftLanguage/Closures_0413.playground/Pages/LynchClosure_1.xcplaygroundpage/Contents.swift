//: [Previous](@previous)

import SwiftUI

public func code(for title: String, sampleCode: ()->()) {
    
    print("""
---------------------------
Result for: "\(title)"
""")
    sampleCode()
}

code(for: "The simpleset Closure") {
    
    func sayHello() {
        print("Hello")
    }
    
    sayHello()
    
    let sayHelloClosure: () -> Void = { print ("Hello") }
    sayHelloClosure()
    
}

code(for: "Closure with parameters") {
    func sayHello(to name: String) {
        print("Hello \(name)")
    }
    sayHello(to: "Bill")
    
    let sayHelloClosure: (String) -> Void = { name in
        print("Hello \(name)")
    }
    
    sayHelloClosure("Kwon")
}

code(for: "Closures that return something") {
    func sum(a: Int, b: Int) -> Int {
        return a + b
    }
    
    let sumClosure:(Int, Int) -> Int = { (s1, s2) in
        return s1 + s2
    }
    
    print(sumClosure(2,3))
    
}

code(for: "Closure as Function Parameter") {
    func sayHello(to name: String, finallySayIt: (String) -> ()) {
        let newName = name.uppercased()
        finallySayIt(newName)
    }
    
    sayHello(to: "Steward", finallySayIt: {
        name in print("Hello \(name)")
    })
    
    //후행 클로저 타입
    sayHello(to: "Kwon") {
        name in print("Helloo \(name)")
    }
    
    let reallySayIt: (String) -> () = { name in
        print("Hellow \(name)")
    }
    
    sayHello(to: "SunMi", finallySayIt: reallySayIt)
}

code(for: "Escaping closure") {
    func sayHell(to name: String, finallySayIt: @escaping (String) -> ()) {
        let newName = name.uppercased()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            finallySayIt(newName)
        }
        
    }
    
    sayHell(to: "Kwon") { name in
        print("Hell 3초 후  \(name)")
    }
}

code(for: "Function returning a closure") {
    func sayIt() -> (String) -> Void {
        return { name in
            print("Hello \(name)")
        }
    }
    sayIt()("Stewart")
}

code(for: "Capturing Values") {
    func counter() -> ()->() {
        var count = 1
        return {
            print("The count is \(count)")
            count += 1
        }
    }
    
    let gameCounter = counter()
    gameCounter()
    gameCounter()
}
