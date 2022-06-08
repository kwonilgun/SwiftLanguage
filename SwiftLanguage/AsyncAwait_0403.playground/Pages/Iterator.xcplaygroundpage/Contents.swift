//
import Foundation

//IteratorProtocol -> A type that supplies the values of a sequence one at a time.
//한번에 하나씩 시퀀스의 값들을 제공하는 타입이다.
//protocol IteratorProtocol

//The IteratorProtocol protocol is tightly linked with the Sequence protocol. Sequences provide access to their elements by creating an iterator, which keeps track of its iteration process and returns one element at a time as it advances through the sequence.
//Whenever you use a for-in loop with an array, set, or any other collection or sequence, you’re using that type’s iterator. Swift uses a sequence’s or collection’s iterator internally to enable the for-in loop language construct.

//array, set,그리고 다른 콜렉션과 시퀀스를 for-in loop를 이용할 때 마다. 내부적인 iterator를 이용한다.
let animals = ["Antelope", "Butterfly", "Camel", "Dolphin"]
for animal in animals {
    print(animal)
}

//The call to animals.makeIterator() returns an instance of the array’s iterator. Next, the while loop calls the iterator’s next() method repeatedly, binding each element that is returned to animal and exiting when the next() method returns nil.
//makeIterator는 array iterator의 인스턴스를 리턴한다.  while loop는 iterator의 next()를 반복적으로 콜한다.

var animalIterator = animals.makeIterator()
while let animal = animalIterator.next() {
    print(animal)
}


//Adding IteratorProtocol Conformance to Your Type
//IteratorProcotocl 준수를 사용자 타입에 추가하기

struct Countdown: Sequence {
    let start: Int
    
    func makeIterator() -> CountdownIterator {
        return CountdownIterator(self)
    }
    
}


struct CountdownIterator: IteratorProtocol {
    let countdown: Countdown
    var times = 0

    init(_ countdown: Countdown) {
        self.countdown = countdown
    }

    mutating func next() -> Int? {
        let nextNumber = countdown.start - times
        guard nextNumber > 0
            else { return nil }

        times += 1
        return nextNumber
    }
}

let threeTwoOne = Countdown(start: 3)

for count in threeTwoOne {
    print("\(count)....")
}
