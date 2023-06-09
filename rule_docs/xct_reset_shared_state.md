# XCTestCase reset shared state

XCTestCase should reset shared state in tearDown()

* **Identifier:** xct_reset_shared_state
* **Enabled by default:** No
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** warning, test_classes: ["XCTestCase"], patterns: [set_up: MySharedStateComponent\s*\.\s*setUp, tearDown: MySharedStateComponent\s*\.\s*tearDown]

## Non Triggering Examples

```swift
class TestCase: XCTestCase {
  override func setUp() {
    super.setUp()
    MySharedStateComponent.setUp()
  }
  override func tearDown() {
    MySharedStateComponent.tearDown()
    super.tearDown()
  }
  func testComponent() {
    MySharedStateComponent.setUp(with: Configuration())
  }
}
```

```swift
class TestCase: XCTestCase {
  override func setUp() {
    super.setUp()
    ComponentMock().setUp()
  }
}
class ComponentMock: Component {
  func setUp() {
    MySharedStateComponent.setUp()
  }
}
```

## Triggering Examples

```swift
class TestCase: XCTestCase {
  override func setUp() {
    super.setUp()
    ↓MySharedStateComponent.setUp()
  }
  override func tearDown() {
    super.tearDown()
  }
}
```

```swift
class TestCase: XCTestCase {
  override func setUp() {
    super.setUp()
    ↓MySharedStateComponent.setUp()
  }
}
```

```swift
class TestCase: XCTestCase {
  func testComponent() {
    ↓MySharedStateComponent.setUp(with: Configuration())
  }
}
```