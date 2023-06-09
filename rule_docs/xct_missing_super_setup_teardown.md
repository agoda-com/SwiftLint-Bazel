# XCTestCase missing super.setUp() or super.tearDown()

XCTestCase that overrides setUp() or tearDown() methods should call super

* **Identifier:** xct_missing_super_setup_teardown
* **Enabled by default:** No
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** warning, test_classes: ["XCTestCase"]

## Non Triggering Examples

```swift
class TestCase: XCTestCase {
  override func setUp() {
    super.setUp()
  }
  override func tearDown() {
    super.tearDown()
  }
}
```

```swift
class TestCase: XCTestCase {}
```

```swift
struct MyStruct {
  func setUp() {
    print("setUp")
  }
  func tearDown() {
    print("tearDown")
  }
}
```

## Triggering Examples

```swift
class TestCase: XCTestCase {
override func ↓setUp() {
  print("setUp")
}
override func ↓tearDown() {
  print("tearDown")
}
override class func ↓setUp() {
  print("setUp")
}
override class func ↓tearDown() {
  print("tearDown")
}
```