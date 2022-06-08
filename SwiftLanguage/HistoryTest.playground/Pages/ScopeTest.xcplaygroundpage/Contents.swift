import SwiftUI

var data = (1 ..< 10)

var even = data.map({
    
    s1  in makeData(value: s1)
})
    .sorted { s1, s2 in
        s1 > s2
    }
    
func makeData(value: Int) -> Int {
    
    return 3 * value
}

print(even)
