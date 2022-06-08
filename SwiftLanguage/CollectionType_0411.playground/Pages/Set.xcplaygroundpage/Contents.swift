import UIKit

//‘A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once.

//Hash values for set types
//A type must be hashable in order to be stored in a set—that is, the type must provide a way to compute a hash value for itself. A hash value is an Int value that’s the same for all objects that compare equally, such that if a == b, the hash value of a is equal to the hash value of b.


var letters = Set<Character>()

letters.insert("a")
print(letters)

//var favoriteGeners: Set<String> = ["Rock", "Classical", "Hip hop"]
var favoriteGeners: Set = ["Rock", "Classical", "Hip hop"]
print(favoriteGeners.count)
favoriteGeners.insert("Jazz")
print(favoriteGeners)


for genre in favoriteGeners {
    print("\(genre)")
}
