//: [Previous](@previous)

import Foundation

//‘Associated Values
//The examples in the previous section show how the cases of an enumeration are a defined (and typed) value in their own right. You can set a constant or variable to Planet.earth, and check for this value later. However, it’s sometimes useful to be able to store values of other types alongside these case values. This additional information is called an associated value, and it varies each time you use that case as a value in your code.’


//타입의 associated value -> 관련값이다. 추가적인 정보가 associated value 이다. 
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCEDFGHI")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
