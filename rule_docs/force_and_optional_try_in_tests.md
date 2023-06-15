# Missed Given/When/Then Rule

Dont use try!/try? in test functions. Use just try instead

* **Identifier:** force_and_optional_try_in_tests
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
        try throwableFunt()
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() async throws {
        try throwableFunt()
        try await asyncThrowableFunt()
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeatureHelper(arg: Arg) throws {
        try throwableFunt()
    }
}
```

```swift
final class MyCase: BaseClass {
    func testMyAwesomeFeature() throws {
        try helperFunc(config: config)
    }

    func anotherAwesomeFeature(config: [String: Any]) throws {
        try throwableFunt()
    }
}
```

## Triggering Examples

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() async {
        ↓try! throwableFunt()
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func helperFunc() async {
        ↓try! throwableFunt()
        ↓try? await asyncThrowableFunt()
    }
}
```

```swift
final class MyTestCase: XCTestCase {
    func testMyAwesomeFeature() throws {
        ↓try? throwableFunt()
    }
}
```