//: [Previous](@previous)

import Foundation

//메서드는 특정 타입에 관련된 함수를 뜻한다.

var arr:[String] = ["Hello", "World"]

//특정 인스턴스에 대한 메서드가 존재한다. 인스턴스 메서드, 타입 메서스를 구별해야 한다.
arr.append("kwon")
print(arr)


//인스턴스 메소드
//클래스 인스턴스 메소드

class LevelClass {
    var level: Int = 0 {
        didSet {
            print("Level: \(self.level)")
        }
    }
    
    func levelUp() {
        print("level up")
        level += 1
    }
    
    func levelDown() {
        print("level down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    //모든 인스턴스는 암시적으로 생성된 self 프로퍼티를 갖는다. 인스턴스 자기 자신을 가리키는 프로퍼티이다. self 프로퍼티는 인스턴스를 더 명확히 지칭하고 싶을 때 사용한다.
    
    func jumpLevel(to level : Int){
        print("jump to \(level)")
        self.level = level
    }
    
    func reset() {
        print("Reset")
        level = 0
    }
}


var levelClassInstance :LevelClass = LevelClass()
levelClassInstance.levelUp()
levelClassInstance.levelDown()
levelClassInstance.levelDown()
levelClassInstance.jumpLevel(to: 3)



//self 프로퍼티의 다른 용도는 값 타입 인스턴스 자체의 값을 치환할 수 있다. 클래스 인스턴스는 참조타입이라서 self 프로퍼티에 다른 참조를 할당할 수 없는데, 구조체나 열거형등은 self 프로퍼티를 사용하여 자신 자체를 치환할 수 있다.

//클래스에서 프로퍼티 값을 변경하는 수정하는 코드가 있다. 자신의 프로퍼티 값을 수정할 때 클래스의 인스턴스 메서드는 크게 신경쓸 필요가 없지만, 구조체와 열거형등은 값 타입이므로 메서드 앞에 mutating 키워드를 붙여서 해당 메소도가 인스턴스 내부의 값을 변경한다는 것을 명시해야 한다. 


struct LevelStruct {
    var level: Int = 0 {
        didSet {
            print("Level: \(self.level)")
        }
    }
    
    mutating func levelUp() {
        print("level up")
        level += 1
    }
    
    mutating func levelDown() {
        print("level down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    //모든 인스턴스는 암시적으로 생성된 self 프로퍼티를 갖는다. 인스턴스 자기 자신을 가리키는 프로퍼티이다. self 프로퍼티는 인스턴스를 더 명확히 지칭하고 싶을 때 사용한다.
    
    mutating func jumpLevel(to level : Int){
        print("jump to \(level)")
        self.level = level
    }
    
    mutating func reset() {
        print("Reset")
        self = LevelStruct()    //구조체는 자기 자신을 치환할 수 있다.
    }
}


var levelStruct: LevelStruct = LevelStruct()
levelStruct.levelUp()
levelStruct.levelDown()
levelStruct.levelDown()
dump(levelStruct)
