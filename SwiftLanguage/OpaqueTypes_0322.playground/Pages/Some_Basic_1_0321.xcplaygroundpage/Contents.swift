//: [Previous](@previous)

import Foundation

func transformToInt(_ array: [String]) -> some Sequence {
    
    return array
        .compactMap { Int($0) }
        .drop (while: { $0 < 10 } )
    
        
}

let values = transformToInt(["1", "2", "20", "Pitt"])
for value in values {
    print(value)
}
