import Foundation

protocol Person {
    var age : Int { get set }
    //var name : String
}


struct Student: Person {
    var age: Int
}

print(Student.self)

//extension Student {
//    var data : Int {
//        get { self[Student.self] }
//    }
//}

extension Student {
    var data : Int {
        get { return self.age}
    }
}

let john = Student(age: 10)
print(john.data)

print(john)
