//: [Previous](@previous)

import Foundation

@propertyWrapper
enum Lazy<Value> {
    case uninitialized(() -> Value)
    case initialized(Value)
    
    var wrappedValue: Value {
        mutating get {
            switch self {
            case let .uninitialized(initializer):
                let value = initializer()
                self = .initialized(value)
                
                return value
            case let .initialized(value):
                return value
            }
        }
        set {
            self = .initialized(newValue)
        }
    }
    
    init(wrappedValue: @autoclosure @escaping () -> Value) {
        self = .uninitialized(wrappedValue)
    }
}

struct Test {
    @Lazy var foo: Int = 17
}

var t = Test()
t.foo

//: [Next](@next)
