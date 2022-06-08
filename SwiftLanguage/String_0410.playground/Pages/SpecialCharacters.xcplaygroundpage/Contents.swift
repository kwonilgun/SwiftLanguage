//: [Previous](@previous)

import Foundation

//‘String literals can include the following special characters:

//The escaped special characters \0 (null character), \\ (backslash), \t (horizontal tab), \n (line feed), \r (carriage return), \" (double quotation mark) and \' (single quotation mark)
//An arbitrary Unicode scalar value, written as \u{n}, where n is a 1–8 digit hexadecimal number (Unicode is discussed in Unicode below)

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496’

print(dollarSign)
