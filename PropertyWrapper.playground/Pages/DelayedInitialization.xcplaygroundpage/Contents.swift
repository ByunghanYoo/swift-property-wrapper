//: [Previous](@previous)

import Foundation

@propertyWrapper
struct DelayedMutable<Value> {
    private var _value: Value? = nil
    
    var wrappedValue: Value {
        get {
            guard let value = _value else {
                fatalError("property accessed before being initialized")
            }
            return value
        }
        set {
            _value = newValue
        }
    }
    
    mutating func reset() {
        _value = nil
    }
}

@propertyWrapper
struct DelayedImmutable<Value> {
    private var _value: Value? = nil
    
    var wrappedValue: Value {
        get {
            guard let value = _value else {
                fatalError("property accessed before being initialized")
            }
            return value
        }
        set {
            if _value != nil {
                fatalError("property initialized twice")
            }
            _value = newValue
        }
    }
}

//: [Next](@next)
