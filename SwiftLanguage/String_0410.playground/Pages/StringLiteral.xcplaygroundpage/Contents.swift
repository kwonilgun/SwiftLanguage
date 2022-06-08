import UIKit

//literal = 문자 그대로 라는 뜻이다. 그 자신이 바로 데이터로 사용되는 것을 이른다.

//‘You can include predefined String values within your code as string literals. A string literal is a sequence of characters surrounded by double quotation marks (").
//String Literal은 qutation marks로 둘러쌓인 문자의 일련의 순서이다.

let someString = "Some string literal value" // String Literal을 나타낸다.

//Multiline String Literals

let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

print(quotation)

let singleLineString = "These are the same."
let multilineString = """
These are the same.
"""

print(singleLineString)
print(multilineString)


//line breaks를 원하지 않는 경우는 줄의 끝에 \ 를 적용하면 된다.

let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
print(softWrappedQuotation)

let lineBreaks = """

This string starts with a line break.
It also ends with a line break.

"""
print(lineBreaks)

let linesWithIndentation = """
   This line doesn't begin with ...
      Thine line begin with four white spaces
   This line doesn't begin with
   """

print(linesWithIndentation)
