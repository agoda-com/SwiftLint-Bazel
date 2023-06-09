# Throwable test cases rule

All test cases must be throwable functions

* **Identifier:** throwable_test_cases
* **Enabled by default:** Yes
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** severity: warning, test_parent_classes: ["QuickSpec", "XCTestCase"]

## Non Triggering Examples

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() throws {
        // Test Something
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() async throws {
        // Test something
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeatureHelper(arg: Arg) {
        // Do something
    }
}
```

```swift
final class MyCase: BaseClass {
    func testMyAwesomeFeature() throws {
        helperFunc(instance as? MyClass)
    }

    func anotherAwesomeFeature(config: [String: Any]) {
        // Do Something
    }
}
```

## Triggering Examples

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() async ↓{
        // Test something
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() ↓{
        // Test something
    }
}
```