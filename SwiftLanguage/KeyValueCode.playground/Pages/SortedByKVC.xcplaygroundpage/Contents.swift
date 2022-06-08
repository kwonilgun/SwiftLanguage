//: [Previous](@previous)

import Foundation

struct Videogame {
    var title:String
    var published:String
    var rating:Double
}

let cyberpunk = Videogame(title: "Cyberpunk 2077", published: "2020", rating: 5)
let titleKeyPath = \Videogame.title

print(cyberpunk[keyPath: titleKeyPath]) // Output: Cyberpunk 2077


//2022.529 : KeyPath의 값 즉 rating에 따라서 값을 소팅을 한다.
extension Array
{
    func sorted<Value: Comparable>(
        keyPath: KeyPath<Element, Value>,
        by areInIncreasingOrder:(Value, Value) -> Bool) -> [Element] {

        //keyPath를 파라미터로 받아서 sorted 에 전달한다. 결국 sorted 함수를 부르고
        return sorted { areInIncreasingOrder(
            $0[keyPath: keyPath], $1[keyPath: keyPath]) }

    }
}

let games = [
    Videogame(title: "Cyberpunk 2077", published: "2020", rating: 3),
    Videogame(title: "Fallout 4", published: "2015", rating: 4.5),
    Videogame(title: "The Outer Worlds", published: "2019", rating: 4.4),
    Videogame(title: "RAGE", published: "2011", rating: 4.6),
    Videogame(title: "Far Cry New Dawn", published: "2019", rating: 4),
]

for game in games.sorted(keyPath: \Videogame.rating, by: >) {
    print(game.title)
}
