import Swift

//입출력 매개변수
//함수 파라미터는 기본적으로 상수입니다. 해당 함수의 바디 내에서 함수 파라미터 값을 변경하려고 하면 컴파일 타일 에러가 발생합니다. 이것은 실수로 파라미터의 값을 변경할 수 없다는 것을 의미합니다. 함수의 파라미터 값을 변경하고 함수 호출이 종료된 후에도 이러한 변경된 값을 유지하고 싶다면 in-out 파라미터 (in-out parameter) 로 대신 정의하십시오.
//in-out 파라미터는 파라미터의 타입 바로 전에 inout 키워드를 작성합니다. in-out 파라미터는 함수로 전달하는 값을 가지고 있고 함수로 부터 이 값을 수정하고 원래 값을 대체하기위해 함수 밖으로 다시 되돌려 줍니다. In-out 파라미터와 컴파일러 최적화의 동작에 대한 자세한 설명은 In-Out 파라미터 (In-Out Parameters) 를 참고 바랍니다.
//in-out 파라미터의 인자로 변수만 전달할 수 있습니다. 상수와 반복은 수정할 수 없기 때문에 인자로 상수 또는 반복 값은 전달할 수 없습니다. 함수에 수정가능함을 알리기 위해 in-out 파라미터에 인자로 전달할 때 변수의 이름 앞에 앰퍼샌드 (&)를 붙여줍니다
//inout의 원리

//inout 매개변수는 다음의 과정을 거친다.
//
//1. 함수가 호출되면, 매개변수로 넘겨진 변수가 복사된다.
//2, 함수 몸체에서, 복사한 값을 수정한다.
//3. 함수가 반환될 때, 변화된 값을 원본 변수에 재할당한다.
//이 동작을 copy-in copy-out 혹은 call by value result 라고 부르며 inout은 실제로 copy-in copy-out의 줄임말 이다.

func addInout(_ name: inout Int) {
    //var local = name
    print(name)
    
    name += 1   // name은 입출력 파라미터이기 때문에 값을 변경할 수 있다. 변수이다. 상수가 아니다.
}

var data: Int = 10
addInout(&data)
print(data)

func addParameter(name:  Int) -> Int {
    // name = 5 //Cannot assign to value: 'name' is a 'let' constant 💇‍♀️ : 즉 매개변수는 상수이기 때문에 값을 변경할 수 없다. 값을 변경하기 위해서는 inout을 타입 앞에 선언을 해 주어야 한다.
    return name + 10
}


//In-Out 파라미터(In-Out Parameters)'
//a는 변수가 되고 someInt값을 a에 복사하고, 이 값을 임의수 저장에 복사한다. 그리고 b에 이 값을 저장한다. b값을 a에 복사, b에 임시 저장값을 카피하고 그리고 a,b 값을 다시 someInt, anotherInt에 카피한다.
//🧚‍♀️: a가 변수가 되기 때문에 copy-in 이 가능하고, 즉 a에 값을 카피하고, b도 변수가 되기 때문에 변경이 가능하고, 결국 처리가 되면 함수가 종료를 하면 a,b는 someInt와 anotherInt에 카피아웃이 된다. 
func swapTwoInts(_ a: inout Int, _ b:inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107

swapTwoInts(&someInt, &anotherInt)

print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")



//()->Int 함수를 리턴한다. a는 변경가능한 파라미터가 된다. [a]는 값을 캡쳐한다. [a]는 획득목록이다.

func someFunction(a: inout Int) -> () -> Int {
    return { [a] in
            return a + 1
        
    }
}


var someData: Int = 10

var ft: ()->Int = someFunction(a: &someData)

print(String(ft()))

print(someData)
