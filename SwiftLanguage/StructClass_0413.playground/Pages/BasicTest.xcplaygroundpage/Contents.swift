// StructBasic_0111.playground

import Foundation


//A,B 는 전역 변수이다.
var A:Int = 0
var B:Int = 0


//C는 Int 이다. get/set을 통해서 C라는 변수를 변경을 할 수 있다.
var C:Int {
    get {
        print("Getting C 값")
        return 1
        
    }
    set {
        print("Recived new value", newValue, " and stored into 'B' ")
        B = newValue
     }
}

var D: Int {
     10     //return이 생략이 되었다.
}
print("C: \(C)")

C = 5   //계산된 프로퍼티와 같은 개념이다.

print("B: \(B)")        // B: 5
print("C: \(C)")        // C: 1
print("D: \(D)")        // D: 10



// When we are getting a value of C it fires get{} part of C property
A = C
print("A: \(A)")        // A: 1

// When we are setting a value to C it fires set{} part of C property
C = 2
print("C: \(C)")        //C: 1

struct AB {
    var x: Int = 0
    var y: Int = 0
}

var ab: AB = AB()   //ab는 AB 타입의 구조체 이다.
var cd = AB()

var abc: AB {
    get{return ab }
    set{
        cd = newValue
    }
}

// print(abc)는 get {return ab}가 작동을 한다.
print(abc)
ab.x = 10
ab.y = 100

cd.x = 20
cd.y = 200

abc = ab
print("abc:\(abc)")
print("cd:\(cd)")



// 위의 것을 잘 참조를 해야 한다. 결국 변수 closureVariable도 get이 실행이 되는 것이다. get은 삭제해도 된다.

var closureVariable:[String]  {
    
    get {
        let arrayString: [String] = ["Kwon", "ILG"]
        print("ㅊㅊㅊ")
        return arrayString
    }
}


//위의 것은 다음과 동일하다. 결국 get 이라는 것이 작용을 하는 것이다. 계산된 프로퍼티와 같은 것이다.
//여기서 get이 생략이 된 것이다.
//변수에 대한 것 변수를 부르면 연산프로퍼티가 작동하는 것 처럼 동작한다.
var closeVar:[String] {
    let arrayString: [String] = ["Kwon", "ILG"]
    print("이상")
    return arrayString
}

print(closureVariable)     // 변수를 부르면 실행을 한다.
print(closeVar)


//이것은 함수를 부른 것이다.
func intFunc () -> Int {
    print("IG Kwon ")
    return 2
}

var value : [String] { return ["Kwon"]}
var values : String { return "Kwon" }
var integer: Int = { () -> Int in
        print("IG")
        return 1
    } ()   //클로저 ()가 실행을 해서 return 1이 실행된다.

var integer_1: Int { return 10 }  // integer_1은 Int type 이고 { return 1} 계산 프로퍼티가 get이 실행이 된다.
var integer_2: Int { intFunc() } //계산 프로퍼티가 작동을 한다. 이렇게 되어서 값이 리턴이 된다. print 가 실행이 되는 경우는 계산프로퍼티가 작동이 되는 것이다. 

do { intFunc() }

print("value: \(value)")
print("values: \(values)")
print("integer: \(integer)")
print("integer_1: \(integer_1)")
print("integer_2: \(integer_2)")


