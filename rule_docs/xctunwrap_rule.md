# XCTUnwrap rule

Use XCTUnwrap instead of force or optional case e.g. try XCTUnwrap(instance as? MyClass)

* **Identifier:** xctunwrap_rule
* **Enabled by default:** Yes
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** severity: warning, test_parent_classes: ["QuickSpec", "XCTestCase"]

## Non Triggering Examples

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() {
        let myClassInstance = try XCTUnwrap(instance as? MyClass)
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() {
        helperFunc(try XCTUnwrap(instance as? MyClass))
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() {
        let str = "some test"
        helperFunc(str as NSString)
        print((str as NSString).lastPathComponent)
    }
}
```

```swift
final class MyCase: BaseClass {
    func testMyAwesomeFeature() {
        helperFunc(instance as? MyClass)
    }

    func anotherAwesomeFeature(config: [String: Any]) {
        guard let priority = config["priority"] as? Priority else { return }
        if let instance = instance as? MyClass {
            // Do something
        }
        let x = config["x"] as! Int
    }
}
```

## Triggering Examples

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() {
        guard let myClassInstance = instance ↓as? MyClass else { XCTFail() }
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() {
        if let myClassInstance = instance ↓as? MyClass
        {

        }
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() {
        let myClassInstance = instance ↓as? MyClass
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() {
        let myClassInstance = instance ↓as! MyClass
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() {
        helperFunc(b ↓as? Int)
        helperFunc(c ↓as! Int)
    }

    func helperFunc(_ a: Int) {
        // Some code here
    }
}
```