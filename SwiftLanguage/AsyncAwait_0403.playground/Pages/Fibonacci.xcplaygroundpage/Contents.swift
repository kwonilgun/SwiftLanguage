
import Foundation

//As you can see, I’ve needed to explicitly write Task { () -> [Int] in so that Swift understands that the task is going to return, but if your task code is simpler that isn’t needed. For example, we could have written this and gotten exactly the same result:

func fibonacci(of number: Int) -> Int {
    var first = 0
    var second = 1

    for _ in 0..<number {
        let previous = first
        first = second
        second = previous + first
    }

    return first
}

func printFibonacciSequence() async {
    let task1 = Task { () -> [Int] in
        var numbers = [Int]()

        for i in 0..<50 {
            let result = fibonacci(of: i)
            numbers.append(result)
        }

        return numbers
    }

    let result1 = await task1.value
    print("The first 50 numbers in the Fibonacci sequence are: \(result1)")
}
