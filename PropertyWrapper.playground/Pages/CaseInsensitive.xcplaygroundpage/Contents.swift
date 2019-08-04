//: [Previous](@previous)

import Foundation

@propertyWrapper
struct CaseInsensitive<Value: StringProtocol> {
    var wrappedValue: Value
    
    var projectedValue: Self { self }
    
    private func compare(_ other: CaseInsensitive) -> ComparisonResult {
        wrappedValue.caseInsensitiveCompare(other.wrappedValue)
    }
}

extension CaseInsensitive: Comparable {
    static func == (lhs: CaseInsensitive<Value>, rhs: CaseInsensitive<Value>) -> Bool {
        lhs.compare(rhs) == .orderedSame
    }
    
    static func < (lhs: CaseInsensitive<Value>, rhs: CaseInsensitive<Value>) -> Bool {
        lhs.compare(rhs) == .orderedAscending
    }
    
    static func > (lhs: CaseInsensitive, rhs: CaseInsensitive) -> Bool {
        lhs.compare(rhs) == .orderedDescending
    }
}

struct Account: Equatable {
    @CaseInsensitive var name: String
    
    init(name: String) {
        self.name = name
    }
}

var johnny = Account(name: "johnny")
johnny.name

let JOHNNY = Account(name: "JOHNNY")
JOHNNY.name

let Jane = Account(name: "Jane")
Jane.name

johnny == JOHNNY // true
johnny == Jane // false

johnny.name == JOHNNY.name // false
johnny.$name == JOHNNY.$name // true

johnny.name = "Johnny"
johnny.name // "Johnny"

//: [Next](@next)
