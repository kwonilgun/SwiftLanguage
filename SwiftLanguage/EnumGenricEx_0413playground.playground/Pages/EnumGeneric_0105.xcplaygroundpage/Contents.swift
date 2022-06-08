
//2022.1.12 - EnumGenericEx_0105.playground

import SwiftUI

// enum generic 예제,,
enum DemoError: Error {
    case randomError
}

enum ResultGen<T,P>{
    
    case success(T)     //연관값이 된다.
    case failure(P)
}

//1월 5일 : 여기서 중요한 것은 ResultGen은 하나의 enum 이다. 혼선이 생긴다
// ResultGen<String, DemoError> 은 한개 매개변수이다.
// 하나의 enum에 대해서 각각의 케이스별로 type을 지정할 수 있다.
func doSomething(completion: (Result<String, DemoError>) -> Void) {
    let isEveryOk = Bool.random()
    
    if isEveryOk {
        completion(.success("Hello"))
    }
    else {
        completion(.failure(.randomError))
    }
}

//Bool.random() 실행 결과에 따라 프린터가 된다.
//doSomething(completion:) { ... }  후행 클로저이다.
//doSomething { <#Result<String, DemoError>#> in
//    <#code#>
//}

doSomething { (result:  Result<String, DemoError>) -> ()  in
    switch result {
    case .success(let value):
        print(value)
    case .failure(let error):
        // this will never happen
        print("error:\(error)")
    }
}

// 클로저 즉 무명 함수를 정의하고 클로저를 실행한다.
var closure = { (result: Result<String, DemoError>) -> () in
    switch result {
    case .success(let value):
        print(value)
    case .failure(let error):
        // this will never happen
        print("error:\(error)")
    }
}
closure(.success("클로저를 성공시켰네💇‍♀️"))   // 아주 중요하다.


// 제네릭 구조체 예제
struct Pool<T, U> {
    var val: T
    var dat: U
    
    init(value: T, data: U){
        self.val = value
        self.dat = data
    }
    
    mutating func updateVal(value: T) {
        self.val = value
    }
    mutating func updateVal(data: U) {
        self.dat = data
        print("sPool:\(self.dat)")
    }
}
//  이것을 에러가 발생한다. 왜냐하면 pool은 구조체이고 값을 변경을 할 수 없다. 하지만 pool,updateVal(data:data)에서
// 값을 변경하려고 하기 때문에 에러가 발생한다.
//func updateValueAndData<T, U>( pool: Pool<T,U>, value: T, data: U) -> () {
//
//    pool.updateVal(data: data)
//}

//구조체에 대해서 두개의 제네릭을 동시에 설정할 수 있다.
var sPool = Pool<Int, String>(value: 5, data: "Kwon")

print(sPool.dat)
sPool.updateVal(data: "권일근")


//updateValueAndData(pool: sPool, value: 10, data: "권일근 ")
// 구조체의 타입을 가지고 함수를 overloading 할 수 있다.

struct Foo<T> {
    let v: T
}

func sameType<T> (a: Foo<T>, b: Foo<T>) -> Bool {
    return true
}

func sameType<T, U> (a: Foo<T>, b: Foo<U>) -> Bool {
    return false
}


let a = Foo(v: 1.0)    //a는 구조체의 인스턴스이지만 타입에서 만들어진 것이고, 이 타입을 유추할 수 있다.

print("a 타입= \(type(of:a))")
let b = Foo(v: "asdf")  //b도 구조체의 인스턴스이고, 타입이 구조체의 String 이다. 타입이 다른 것이다.
print("b 타입= \(type(of:b))")

//타입 유추가 작동이 된다.
print(sameType(a: a, b: b)) // false
print(sameType(a: a, b: a)) // true




//여기서 L, R는 타입을 유추할 수가 있다. 타입이 같으면
func sameType<L,R>(left: L, right: R) -> Bool {
    if let cast = left as? R {
        print("left.if 타입:\(type(of:left))")
        print("right.if 타입:\(type(of:right))")
        print("cast 타입: \(type(of: cast))")
        return true
    } else {
        print("left.else 타입:\(type(of:left))")
        print("right.else 타입:\(type(of:right))")
        return false
    }
}

//타입을 비교하는 것이다.
func compare<T,U>(foo: T, bar: U) -> Bool {
    return sameType(left: foo, right: bar)
}



print(sameType(left: a, right: b))  //false

print(sameType(left: a, right: a))  //true

print(compare(foo: a, bar: b))   //false
print(compare(foo: a, bar: a))   //true
