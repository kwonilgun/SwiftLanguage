//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//Class-Only Protocols
//You can limit protocol adoption to class types (and not structures or enumerations) by adding the AnyObject protocol to a protocol’s inheritance list.
//protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
//    // class-only protocol definition goes here
//}
//
//In the example above, SomeClassOnlyProtocol can only be adopted by class types. It’s a compile-time error to write a structure or enumeration definition that tries to adopt SomeClassOnlyProtocol.’

