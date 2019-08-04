import Foundation

func clamp<Value: Comparable>(_ value: Value, in range: ClosedRange<Value>) -> Value {
    return min(max(range.lowerBound, value), range.upperBound)
}

@propertyWrapper
struct Clamping<Value: Comparable> {
    private(set) var value: Value
    private let range: ClosedRange<Value>
    
    init(wrappedValue initialValue: Value, _ range: ClosedRange<Value>) {
        self.value = clamp(initialValue, in: range)
        self.range = range
    }
    
    var wrappedValue: Value {
        get { value }
        set { value = clamp(newValue, in: range) }
    }
}

struct Solution {
    @Clamping(0...14) var pH: Double = 7.0
}

let carboicAcid1 = Solution(pH: 4.68)
print(carboicAcid1.pH)

let carboicAcid2 = Solution(pH: -1)
print(carboicAcid2.pH)

//: [Next](@next)
