//: [Previous](@previous)

import Foundation

//Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.

//프로퍼티 옵저버는 프로퍼티 값에 변화가 있으면 반응한다. 프로퍼티 값이 세팅될 때마다 불려진다. new value가 current value의 값과 같을 지라도 불려진다.

//You have the option to define either or both of these observers on a property:
//
//willSet is called just before the value is stored.
//didSet is called immediately after the new value is stored.’

//💇‍♀️💇‍♀️totalSteps에 값을 세팅하면 willSet와 didSet이 불려진다. willSet는 새로운 값을 didSet는 새로 쓰여지는 값이 totalSteps이고, 이전의 값 즉 totalStep의 이전 값이 oldValue가 된다.


class StepCounter {
    var totalSteps: Int = 0 {
//        willSet(newTotalSteps) {
//            //totalSteps에 newTotalSteps을 쓰기 전에 불려진다.
//            print("About to set totalSteps to \(newTotalSteps)")
//            print("totalSteps 현재의 값:\(totalSteps)")
//        }
        willSet { //쓰기 전에 불려진다.
            //totalSteps에 newTotalSteps을 쓰기 전에 불려진다.
            print("About to set totalSteps to \(newValue)")
            print("totalSteps 현재의 값:\(totalSteps)")
        }
        didSet {
            //쓰여진 후에 불려진다. oldValue는 totalSteps의 이전 값이 된다. 이미 totalSteps는 새로운 값으로 업테이트가 되었다.
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
//totalSteps 현재의 값: 0
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps


//‘The didSet observer is called after the value of totalSteps is updated. It compares the new value of totalSteps against the old value. If the total number of steps has increased, a message is printed to indicate how many new steps have been taken. The didSet observer doesn’t provide a custom parameter name for the old value, and the default name of oldValue is used instead.
