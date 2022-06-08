//Async/await: sequences

import Foundation
import SwiftUI

//introduces the ability to loop over asynchronous sequences of values using a new AsyncSequence protocol. This is helpful for places when you want to process values in a sequence as they become available rather than precomputing them all at once – perhaps because they take time to calculate, or because they aren’t available yet.

//Using AsyncSequence is almost identical to using Sequence, with the exception that your types should conform to AsyncSequence and AsyncIterator, and your next() method should be marked async. When it comes time for your sequence to end, make sure you send back nil from next(), just as with Sequence.

//For example, we could make a DoubleGenerator sequence that starts from 1 and doubles its number every time it’s called:

struct DoubleGenerator: AsyncSequence {
    typealias Element = Int

    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 1

        mutating func next() async -> Int? {
            defer { current &*= 2 }

            if current < 0 {
                return nil
            } else {
                return current
            }
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }
}

func printAllDoubles() async {
    for await number in DoubleGenerator() {
        print(number)
    }
}

func containsExactNumber() async {
    let doubles = DoubleGenerator()
    let match = await doubles.contains(16_777_216)
    print(match)
}

//전용 타스크를 만들어서 중지를 시키고, await 를 한다.
func doRegularWork() {
    Task {
        await printAllDoubles()
    }
}

doRegularWork()

