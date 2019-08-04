//: [Previous](@previous)

import Foundation

@propertyWrapper
class DelayedMutable<Value> {
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
    var projectedValue: DelayedMutable { self }
    
    /// 이 함수를 사용하기 위해서는 DelayedMutable을 struct가 아닌 class로 선언하는 방법 밖에 없을 것 같다.
    func reset() {
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

class Foo {
    @DelayedMutable var x: Int
    @DelayedImmutable var y: Int
    
    /// x, y 모두 non-optionl로 선언했지만 initializer에서 초기화하지 않는다.
    init() {
    }
    
    func initializeX(x: Int) {
        self.x = x
    }
    
    func initializeY(y: Int) {
        self.y = y
    }
}

var foo = Foo()
foo.x = 1
foo.y = 2
(foo.x, foo.y)

foo.x = 3
(foo.x, foo.y)

foo.$x.reset()
//foo.x // crash

//foo.y = 4 // crash!

//: [Next](@next)
