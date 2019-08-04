//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Versioned<Value> {
    private var value: Value
    private(set) var timestampedValues: [(Date, Value)] = []
    
    var wrappedValue: Value {
        get { value }
        set {
            value = newValue
            addVersion(value: value)
        }
    }
    var projectedValue: Self { self }
    
    init(wrappedValue value: Value) {
        self.value = value
        addVersion(value: value)
    }
    
    private mutating func addVersion(value: Value) {
        timestampedValues.append((Date(), value))
    }
}

class ExpenseReport {
    enum State { case submitted, received, approved, denied }
    
    @Versioned var state: State = .submitted
}

var report = ExpenseReport()
report.state

report.state = .received
report.state
report.$state.timestampedValues

//report.state.timestampedValues

//: [Next](@next)
