//Effectful read-only properties

import Foundation

import SwiftUI

//upgrades Swift’s read-only properties to support the async and throws keywords, either individually or together, making them significantly more flexible.

//To demonstrate this, we could create a BundleFile struct that attempts to load the contents of a file in our app’s resource bundle. Because the file might not be there, might be there but can’t be read for some reason, or might be readable but so big it takes time to read, we could mark the contents property as async throws like this:

enum FileError: Error {
    case missing, unreadable
}


//contents가 async 와 throwing이기 때문에, try await를 이용해야만 한다.

struct BundleFile {
    let filename: String

    var contents: String {
        get async throws {
            guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
                throw FileError.missing
            }

            do {
                return try String(contentsOf: url)
            } catch {
                throw FileError.unreadable
            }
        }
    }
}

func printHighScores() async throws {
    let file = BundleFile(filename: "highscores")
    do {
        try await print(file.contents)
    } catch FileError.missing {
        print("missing")
        throw FileError.unreadable
    } catch FileError.unreadable {
        print("unreadable")
    }
}


//전용 타스크를 만들어서 중지를 시키고, await 를 한다.
func doRegularWork() {
    Task {
        do {
            try await printHighScores()
        } catch {
            print(error)
        }
    }
        
}

doRegularWork()

