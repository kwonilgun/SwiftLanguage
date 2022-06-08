//: [Previous](@previous)

import Foundation

//‘Type aliases define an alternative name for an existing type. You define type aliases with the typealias keyword.

typealias AudioSample = UInt16

var maxAmplitudeFound = AudioSample.max
print(maxAmplitudeFound)
