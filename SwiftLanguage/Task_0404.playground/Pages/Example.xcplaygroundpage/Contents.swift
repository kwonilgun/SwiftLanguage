//: [Previous](@previous)

import Foundation
import SwiftUI

//Task -> it is simply a piece of code with a specific priority — one of four possible priorities in Swift 5.5.


func changer(newColor:Color, delay:Int) async throws -> Color {
  debugPrint("delay \(newColor) \(delay)")
  textDelay[newColor] = delay
  try await Task.sleep(seconds: delay)
  return newColor
}
