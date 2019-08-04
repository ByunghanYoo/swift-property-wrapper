//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Copying<Value: NSCopying> {
    private var _value: Value
    
    var wrappedValue: Value {
        get { _value }
        set {
            _value = newValue.copy() as! Value
        }
    }
    
    init(wrappedValue value: Value) {
        self._value = value.copy() as! Value
    }
}

//: [Next](@next)
