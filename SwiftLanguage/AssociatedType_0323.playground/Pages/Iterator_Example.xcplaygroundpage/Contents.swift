//: [Previous](@previous)

import Foundation

/// A type that supplies the values of a sequence one at a time.
///
/// The `IteratorProtocol` protocol is tightly linked with the `Sequence`
/// protocol. Sequences provide access to their elements by creating an
/// iterator, which keeps track of its iteration process and returns one
/// element at a time as it advances through the sequence.
///
/// Whenever you use a `for`-`in` loop with an array, set, or any other
/// collection or sequence, you're using that type's iterator. Swift uses a
/// sequence's or collection's iterator internally to enable the `for`-`in`
/// loop language construct.
///
/// Using a sequence's iterator directly gives you access to the same elements
/// in the same order as iterating over that sequence using a `for`-`in` loop.
/// For example, you might typically use a `for`-`in` loop to print each of
/// the elements in an array.
///
     let animals = ["Antelope", "Butterfly", "Camel", "Dolphin"]
     for animal in animals {
         print(animal)
     }
     // Prints "Antelope"
     // Prints "Butterfly"
     // Prints "Camel"
     // Prints "Dolphin"



/// Behind the scenes, Swift uses the `animals` array's iterator to loop over
/// the contents of the array.
///
     print("-------------------")
     var animalIterator = animals.makeIterator()
     while let animal = animalIterator.next() {
         print(animal)
     }
     // Prints "Antelope"
     // Prints "Butterfly"
     // Prints "Camel"
     // Prints "Dolphin"
///
/// The call to `animals.makeIterator()` returns an instance of the array's
/// iterator. Next, the `while` loop calls the iterator's `next()` method
/// repeatedly, binding each element that is returned to `animal` and exiting
/// when the `next()` method returns `nil`.
///
/// Using Iterators Directly
/// ========================
///
/// You rarely need to use iterators directly, because a `for`-`in` loop is the
/// more idiomatic approach to traversing a sequence in Swift. Some
/// algorithms, however, may call for direct iterator use.
///
/// One example is the `reduce1(_:)` method. Similar to the `reduce(_:_:)`
/// method defined in the standard library, which takes an initial value and a
/// combining closure, `reduce1(_:)` uses the first element of the sequence as
/// the initial value.
///
/// Here's an implementation of the `reduce1(_:)` method. The sequence's
/// iterator is used directly to retrieve the initial value before looping
/// over the rest of the sequence.
///
///     extension Sequence {
///         func reduce1(
///             _ nextPartialResult: (Element, Element) -> Element
///         ) -> Element?
///         {
///             var i = makeIterator()
///             guard var accumulated = i.next() else {
///                 return nil
///             }
///
///             while let element = i.next() {
///                 accumulated = nextPartialResult(accumulated, element)
///             }
///             return accumulated
///         }
///     }
///
/// The `reduce1(_:)` method makes certain kinds of sequence operations
/// simpler. Here's how to find the longest string in a sequence, using the
/// `animals` array introduced earlier as an example:
///
///     let longestAnimal = animals.reduce1 { current, element in
///         if current.count > element.count {
///             return current
///         } else {
///             return element
///         }
///     }
///     print(longestAnimal)
///     // Prints Optional("Butterfly")
///
/// Using Multiple Iterators
/// ========================
///
/// Whenever you use multiple iterators (or `for`-`in` loops) over a single
/// sequence, be sure you know that the specific sequence supports repeated
/// iteration, either because you know its concrete type or because the
/// sequence is also constrained to the `Collection` protocol.
///
/// Obtain each separate iterator from separate calls to the sequence's
/// `makeIterator()` method rather than by copying. Copying an iterator is
/// safe, but advancing one copy of an iterator by calling its `next()` method
/// may invalidate other copies of that iterator. `for`-`in` loops are safe in
/// this regard.
///
/// Adding IteratorProtocol Conformance to Your Type
/// ================================================
///
/// Implementing an iterator that conforms to `IteratorProtocol` is simple.
/// Declare a `next()` method that advances one step in the related sequence
/// and returns the current element. When the sequence has been exhausted, the
/// `next()` method returns `nil`.
///
/// For example, consider a custom `Countdown` sequence. You can initialize the
/// `Countdown` sequence with a starting integer and then iterate over the
/// count down to zero. The `Countdown` structure's definition is short: It
/// contains only the starting count and the `makeIterator()` method required
/// by the `Sequence` protocol.
///
     struct Countdown: Sequence {
         let start: Int

         func makeIterator() -> CountdownIterator {
             return CountdownIterator(self)
         }
     }
///
/// The `makeIterator()` method returns another custom type, an iterator named
/// `CountdownIterator`. The `CountdownIterator` type keeps track of both the
/// `Countdown` sequence that it's iterating and the number of times it has
/// returned a value.
///
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

/// Each time the `next()` method is called on a `CountdownIterator` instance,
/// it calculates the new next value, checks to see whether it has reached
/// zero, and then returns either the number, or `nil` if the iterator is
/// finished returning elements of the sequence.
///
/// Creating and iterating over a `Countdown` sequence uses a
/// `CountdownIterator` to handle the iteration.
///
///
    print("-------------------")
     let threeTwoOne = Countdown(start: 3)
     for count in threeTwoOne {
         print("\(count)...")
     }
     // Prints "3..."
     // Prints "2..."
     // Prints "1..."
//public protocol IteratorProtocol {

    /// The type of element traversed by the iterator.
//    associatedtype Element

    /// Advances to the next element and returns it, or `nil` if no next element
    /// exists.
    ///
    /// Repeatedly calling this method returns, in order, all the elements of the
    /// underlying sequence. As soon as the sequence has run out of elements, all
    /// subsequent calls return `nil`.
    ///
    /// You must not call this method if any other copy of this iterator has been
    /// advanced with a call to its `next()` method.
    ///
    /// The following example shows how an iterator can be used explicitly to
    /// emulate a `for`-`in` loop. First, retrieve a sequence's iterator, and
    /// then call the iterator's `next()` method until it returns `nil`.
    ///
    ///     let numbers = [2, 3, 5, 7]
    ///     var numbersIterator = numbers.makeIterator()
    ///
    ///     while let num = numbersIterator.next() {
    ///         print(num)
    ///     }
    ///     // Prints "2"
    ///     // Prints "3"
    ///     // Prints "5"
    ///     // Prints "7"
    ///
    /// - Returns: The next element in the underlying sequence, if a next element
    ///   exists; otherwise, `nil`.
 //   mutating func next() -> Self.Element?
//}

/// A type that provides sequential, iterated access to its elements.
///
/// A sequence is a list of values that you can step through one at a time. The
/// most common way to iterate over the elements of a sequence is to use a
/// `for`-`in` loop:
///
///     let oneTwoThree = 1...3
///     for number in oneTwoThree {
///         print(number)
///     }
///     // Prints "1"
///     // Prints "2"
///     // Prints "3"
///
/// While seemingly simple, this capability gives you access to a large number
/// of operations that you can perform on any sequence. As an example, to
/// check whether a sequence includes a particular value, you can test each
/// value sequentially until you've found a match or reached the end of the
/// sequence. This example checks to see whether a particular insect is in an
/// array.
///
     let bugs = ["Aphid", "Bumblebee", "Cicada", "Damselfly", "Earwig"]
     var hasMosquito = false
     for bug in bugs {
         if bug == "Mosquito" {
             hasMosquito = true
             break
         }
     }
     print("'bugs' has a mosquito: \(hasMosquito)")
     // Prints "'bugs' has a mosquito: false"

/// The `Sequence` protocol provides default implementations for many common
/// operations that depend on sequential access to a sequence's values. For
/// clearer, more concise code, the example above could use the array's
/// `contains(_:)` method, which every sequence inherits from `Sequence`,
/// instead of iterating manually:
///
     if bugs.contains("Mosquito") {
         print("Break out the bug spray.")
     } else {
         print("Whew, no mosquitos!")
     }
     // Prints "Whew, no mosquitos!"

/// Repeated Access
/// ===============
///
/// The `Sequence` protocol makes no requirement on conforming types regarding
/// whether they will be destructively consumed by iteration. As a
/// consequence, don't assume that multiple `for`-`in` loops on a sequence
/// will either resume iteration or restart from the beginning:
///
///     for element in sequence {
///         if ... some condition { break }
///     }
///
///     for element in sequence {
///         // No defined behavior
///     }
///
/// In this case, you cannot assume either that a sequence will be consumable
/// and will resume iteration, or that a sequence is a collection and will
/// restart iteration from the first element. A conforming sequence that is
/// not a collection is allowed to produce an arbitrary sequence of elements
/// in the second `for`-`in` loop.
///
/// To establish that a type you've created supports nondestructive iteration,
/// add conformance to the `Collection` protocol.
///
