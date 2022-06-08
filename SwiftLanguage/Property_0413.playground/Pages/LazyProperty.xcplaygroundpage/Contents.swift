//: [Previous](@previous)

import Foundation

//‘Lazy Stored Properties
//A lazy stored property is a property whose initial value isn’t calculated until the first time it’s used. You indicate a lazy stored property by writing the lazy modifier before its declaration.’

//사용되기 전에는 초기 값이 수행되지 않는다.

class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

print(manager.data)
print(manager.importer.filename)

