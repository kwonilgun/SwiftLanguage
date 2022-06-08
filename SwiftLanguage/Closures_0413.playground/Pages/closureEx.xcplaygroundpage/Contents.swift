//closureEx0111.playground

import Swift

//closure 정렬 메서드(The Sorted Method)''
/*'
 클로저 (Closures) 는 코드에서 주변에 전달과 사용할 수 있는 자체 포함된 기능 블럭입니다. Swift의 클로저는 C와 Objective-C의 블럭과 다른 프로그래밍 언어의 람다와 유사합니다.
 클로저는 사용자의 코드 안에서 전달되어 사용할 수 있는 로직을 가진 중괄호{} 로 구분된 코드의 블럭이며, 일급 객체의 역할을 할 수 있다. 일급 객체는 전달 인자로 보낼 수 있고, 변수/상수 등으로 저장하거나 전달을 할 수 있으며 함수의 반환 값이 될 수 있다.
 
 함수는 클로저의 한 형태로 이름이 있는 클로저이다.
 
 {
    (인자들) -> 반환타입 in 로직 구현
 }
 */


//💇‍♀️ -> 함수 타입에 대해서
// 함수 타입은 기존에 Int, String 과 같이 타입으로 정해서 전달을 할 수가 있다.
//이것은  callback 함수를 구현한 것이다. 그리고 콜백함수를 부르면서 동시에 파라미터도 전달을 한다.
//전형적은 예제이다. 콜백과 파라미터 동시 전달을 한다. 함수 타입을 클로저로 전달을 한다.

func oneFuntction(task: (Int) -> Int) -> String {
    return String(task(2))
}

let oneString = oneFuntction { s1 in
    s1 + 3
}

let anotherString = oneFuntction { a1 in
    a1 + 5
}

print(oneString)
print(anotherString)

let oneStringDirect = {s1 in String(s1 + 4) }(2)

print(oneStringDirect)

func twoFunction(task:(Int, Int) -> Int) -> String{
    return String(task(4,3))
}

let twoString = twoFunction { s1, s2 in
    s1 + s2
}

print(twoString)


func ftClosure( a: Int, b: Int, task: (Int, Int) -> Int) -> Int {
    return task(a, b)
}





//후행 클러저
let rValue = ftClosure(a: 10, b: 25) { (s1: Int, s2: Int) -> Int in
    return s1 + s2
}

let rValue_1 = ftClosure(a: 20, b: 20) { s1, s2 in
    s1 * s2
}

let rValue_2 = ftClosure(a: 10, b: 10) { s1, s2 in
    s1 * s2
}

let rValue_3 = ftClosure(a: 20, b: 20) { $0 + $1 }
print(rValue)
print(rValue_1)
print(rValue_3)


let rValueNoName = {(s1: Int, s2: Int) -> Int in
    return s1 + s2
}(5, 6)
print(rValueNoName)

func repetit ( task : () ->Void ) {
    for _ in 0..<1 {
        task()
    }
}

repetit(task: {() -> Void in
    print("IGKwon")
    print("SM Park")
})


//후행 클로저에서 한단계 전
repetit(task:) {() -> Void in
    print("Kwon")
    print("IG Kwon")
}

//위의 후행 클로저에서 ()를 없애고, ()->Void도 없애고, 해서 정리된 형태이다.
repetit {
    print("권일근 ")
    print("박선미")
}

//(Int, Int) -> Bool 클로저를 받아서 실행한다.
func returnValue(a: Int, b: Int, task: (Int, Int) -> Bool ) -> () {
    for _ in 0..<1 {
        let value = task(a, b)
        print(value)
    }
}

//💇‍♀️ -> 이거 아주 재미있네요....
returnValue(a: 20, b: 30) { (data1: Int, data2: Int) -> Bool in
    return data1 < data2
}

returnValue(a: 10, b: 10) { s1, s2 in
    s1 > s2
}


//💇‍♀️ -> 함수 때 배운 대로 Parameter의 "name"은 단독으로 쓰였으니, Argument Label이자, Parameter Name이겠네여? 라고 생각할 수 있지만, 클로저에선 Argument Label을 사용하지 않음따라서, name은 Argument Label이 아니고, 오직 Parameter Name임 따라서 좀이따 보겠지만 다음과 같이 클로저를 호출할 땐

let returnFunction = { (d1: String, d2: String) -> String in
    return d1 + d2
}


let stringPlus = returnFunction("hello", " wolrd")
print(stringPlus)




//💇‍♀️-> 일급 객체로써 클로저

//1. 이름이 없는 경우
  // 아주 중요하다. 이름없는 클로저 뒤에 () 함수를 붙여서 실행하면 함수가 실행이 되는 것이다.

func doSomething(close: ()->() ){
    close()
}

let closure = { () -> () in print("이름없는 함수, 클로저 적용")}  //이름이 없는 일급함수

closure()

doSomething(close: closure)
doSomething(close:) { print("후행클로저")}
doSomething {
    print("안녕하세요")
}


//2. 이름이 있는 경우
func closerFunction() -> () {
    print("이름 있는 함수 적용")
}
let closure_1 = closerFunction   // 이름이 있는 함수의 일급함수 이다.
doSomething(close: closure_1)
doSomething(close: closerFunction)





//3. 클로저를 직접 적용
doSomething(close: { ()->() in print("직접 클로저 함수")})
doSomething {
    print("생략 클로저 함수 적용")
}

var ftClosure = { ()-> () in print("익명함수 실행")}
ftClosure()


//(Int, Int) -> Int 클로저를 받아서 실행한다.
func returnInt(task: (_ data1: Int, _ data2: Int) -> Int) -> Void {
    
    //함수를 받아는다.
    let value = task(10, 22)
    print(value)
}

returnInt { data1, data2 in
    return data1 + data2
}


var returnClosure = { (data1: String, data2: String) -> String in
      
    let value1 = data1 + " "
    let value2 = data2 + " "
    
    return value1 + value2
}("Hello", "Kwon")

print(returnClosure)


//()->Void 클로저를 받아서 실행한다.
func build( content: () -> () ) -> String {
    content()
    return "Hello"
}

func buildVoid(content: ()->() ) {
    content()
}
//build(content: <#T##() -> ()#>) 클로저를 넘겨준다.

var stringValue = build {  //클로저를 넘겨준다.
    print("결과빌드")
    print("테스트하기")
}
print(stringValue)

var stringValue1: () = buildVoid {
    print("Kwon")
    print("IG Kwon")
}


//함수를 넘겨 받고, 매개 변수도 받는다.

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int)
{
    print("Result: \(mathFunction(a, b))")
}
printMathResult(mathFunction: { f, g in
    f + g
}, 3, 5)


//1. resultBuilder가 String 합성을 리턴한다.
@resultBuilder
struct StringBuilder {
    
    typealias Component = String
    
    static func buildBlock(_ components: Component...) -> Component {
        
        //여러개의 스트링을 받아서, Array로 변환해 준다.
        //Cannot convert return expression of type '[StringBuilder.Component]' (aka 'Array<String>') to return type 'StringBuilder.Component' (aka 'String')
        //이것이 중요하다. components는 여기서 [String] 을 만들어서 반환한다.
        // 여기서 리턴이 String 이기 때문에 components를 스트링으로 변환이 필요하다.
        //components
        components.joined(separator: ",")  //Array를 연결해서 String으로 만들어 준다.
    }
    
}

// 클로저를 받아서 함수를 실행하는 것이다. 외부에서 함수를 만들어서 보내면 실행이 된다. 
func Build(@StringBuilder content: ()-> String) -> String {
    content()
}

// {
//   "100"
//.  "200"
//.  "300"
// }
// 💇‍♀️ -> 변환이 되어서 various arguments로 입력되고 최종적으로 String으로 변환이 되어서 리턴된다.
// 결국 content()를 수행하면 이들 스트링이 합쳐져서 하나의 String으로 만들어져서 리턴을 하게 된다.
var buildString = Build {
    "100"    //이것이 함수 내에서 하나씩 실행이 된다, 즉 Argument로 입력이 된다.
    "200"    // 그래서 "100",
    "300"
}

print(buildString)

let names = ["Chirs", "Alex", "Ewa", "Barry", "Daniella"]

/*
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1>s2
}
var reverseNames = names.sorted(by: backward)
 */


//클러저
//var reverseNames = names.sorted(by: {s1, s2 in s1 > s2})
//후행 클로저이다. 이 클로저를 받아서 실행을 한다. 대부분 이런 형태이다.
var reverseNames = names.sorted(){ s1, s2 in
    s1 < s2
}
print(reverseNames)

//opposite 라는 정상적인 함수이다. 함수도 클로저이다.
func opposite(s1: String, s2: String) -> Bool  {
    return s1 > s2
}

//let ft: ((String, String) -> Bool ) = opposite(s1:s2:)
//클로저이다. 일급 객체이다. 객체는 상수나 변수로 처리를 할 수 있다.
//이 클로저를 상수 ft에 저장하고 sorted에 클로저를 전달해서 names를 소팅하도록 한다.
//클로저를 적용한 것이다.
let ft = { (s1: String, s2: String) -> Bool in return s1 > s2 }

reverseNames = names.sorted(by: ft)
print(reverseNames)

var reverse = names.sorted(by: { s1, s2 in
     s1 > s2
})

//reverse = names.sorted(by: <#T##(String, String) throws -> Bool#>)
//후행 클러저
//인자로 클로저를 넣기가 길다면 후행 클로저를 사용하여 함수 뒤에 표한할 수 있다.
var reverseClosureName = names.sorted(){(s1:String, s2:String ) in s1 > s2}
print(reverseClosureName)


/*
 Escaping Closure:
 : 클로저가 함수의 인자로 전달되지만 함수 밖에서 실행되는 것(함수가 반환된 후 실행되는 것)을 Escape한다고 하며, 이러한 경우 매개변수의 타입 앞에 @escaping이라는 키워드를 명시해야한다. 다음과 같은 경우에 자주 사용된다.
 비동기로 실행되는 경우
 completionHandler(완료에 따른 처리)로 사용되는 클로저의 경우
 일반 지역변수가 함수 밖에서 살아있는 것은 전역변수를 함수에 가져와서 값을 주는 것과 다름이 없지만, 클로저의 Escaping은 하나의 함수가 마무리된 상태에서만 다른 함수가 실행되도록 함수를 작성할 수 있다는 점에서 유리하다. 즉, 이를 활용해서 함수 사이에 실행 순서를 정할 수 있다.
 */


var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
  completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
  closure()    // 함수 안에서 끝나는 클로저
}

class SomeClass {
  var x = 10
  func doSomething() {
    someFunctionWithEscapingClosure() { self.x = 100 } // 명시적으로 self를 적어줘야 한다.
    someFunctionWithNonescapingClosure() { x = 200 }
  }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x) // 200
completionHandlers.first?()
print(instance.x) // 100

//@escaping 속성자를 이용해서 핸들러를 만들어서 동작이 완료된 이후에도 함수가 실행이 될 수
//있도록 처리를 한다.
var completionH: [(Int, Int) -> Int] = []
func addAfterEscaping(handler: @escaping (_ aInput: Int, _ bInput: Int) -> Int){
    
    completionH.append(handler)
}

class EscapeClass {
    var a = 10
    var b = 10
    
    func doSomething() {
        
        addAfterEscaping { aInput, bInput in
            return aInput + bInput
        }
    }
}

let eInstance = EscapeClass()
eInstance.doSomething()

let integer = completionH.first?(1,2)
print(integer!)


/*
 AutoClosure
 :  자동 클로저는 인자 값이 없으며 특정 표현을 감싸서 다른 함수에 전달 인자로 사용할 수 있는 클로저를 말한다. 자동 클로저는 클로저를 실행하기 전까지 실제 실행이 되지 않는다. 즉 실제 계산이 필요할때 호출이 되기 때문에 계산이 복잡한 연산을 하는데 유용하다.
 */

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count) // 5

//이것을 클로저이다. 클로저는 일급 시민임으로 변수에 저장을 할 수 있다.
let customerProvider = { customersInLine.remove(at: 0) } // 해당 코드가 지나도 count가 줄지 않는다.
print(customersInLine.count) // 5
// customerProvider가 실행되었을때만 동작
customerProvider()
//print("Now serving \(customerProvider())!") // "Now serving Chris!"
print(customersInLine.count) // 4

//오토 클로저가 없기 때문에  {} 붙여서 넘겨 주어야 한다.
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } ) // "Now serving Alex!"


// customersInLine is ["Ewa", "Barry", "Daniella"]
//@autoclosure는 {} 이것을 자동으로 붙여준다.
func serve(customer customerProvider: @autoclosure () -> String) {
  print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0)) // "Now serving Ewa!"
