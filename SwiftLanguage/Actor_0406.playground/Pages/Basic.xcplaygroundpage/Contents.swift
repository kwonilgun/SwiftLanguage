//: [Previous](@previous)

//import Foundation
import SwiftUI

//What are Actors?
//Actors in Swift are not new: they’re inspired by the Actor Model that treats actors as the universal primitives of concurrent computation. However, proposal SE-0306 introduced Actors and explain which problem they solve: Data Races.
//
//Data races occur when the same memory is accessed from multiple threads without synchronization, and at least one access is a write. Data Races can lead to unpredictable behavior, memory corruption, flaky tests, and weird crashes. You might have crashes that you’re unable to solve today as you have no clue when they happen, how you can reproduce them, or how you can fix them based on theory. My article Thread Sanitizer explained: Data Races in Swift explains in-depth how you can solve, find, and fix Data Races.
//
//Actors in Swift protect their state from data races, and using them allows the compiler to give us helpful feedback while writing applications. In addition, the Swift compiler can statically enforce the limitations that come with actors and prevents concurrent access to mutable data.
//
//You can define an Actor using the actor keyword, just like you would with a class or a struct:


//Actors are like other Swift types as they can also have initializers, methods, properties, and subscripts, while you can also use them with protocols and generics. Furthermore, unlike structs, an actor requires defining initializers when your defined properties require so manually. Lastly, it’s important to realize actors are reference types.


actor ChickenFeeder {
    let food = "worms"
    var numberOfEatingChickens: Int = 0
    
    func chickenStartsEating() {
        numberOfEatingChickens += 1
    }
    
    func chickenStopsEating() {
        numberOfEatingChickens -= 1
    }
}


//feeder.chickenStopsEating()


//As we’re unsure when access is allowed, we need to create asynchronous access to our Actor’s mutable data. If there’s no other thread accessing the data, we will directly get access. If there’s another thread performing access to the mutable data, however, we need to sit and wait till we’re allowed to go through.



extension ChickenFeeder {
    func notifyObservers() {
        NotificationCenter.default.post(name: NSNotification.Name("chicken.started.eating"), object: numberOfEatingChickens)
    }
}

//데이타 접근을 기다리게 한다.
//func wait() async {
//
//    await feeder.chickenStartsEating()
//    print(await feeder.numberOfEatingChickens)
//}

//데이타 접근을 기다리게 한다.
func wait() async {
    let feeder = ChickenFeeder()
    await feeder.chickenStartsEating()
    await feeder.notifyObservers()
}


func doRegularWork() {
    Task {
        await wait()
    }
}

doRegularWork()
