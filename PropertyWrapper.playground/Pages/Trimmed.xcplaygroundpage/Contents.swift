//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Trimmed {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}

struct Post {
    @Trimmed var title: String
    @Trimmed var body: String
}

var quine = Post(title: "  Swift Property Wrappers   ", body: "bla bal  \n")
quine.title
quine.body

quine.title = "      @propertyWrapper   \n  "
quine.title

//: [Next](@next)
