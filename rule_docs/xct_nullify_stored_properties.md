# XCTestCase nullify all stored properties

XCTestCase should nullify all stored properties in tearDown()

* **Identifier:** xct_nullify_stored_properties
* **Enabled by default:** No
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** warning, test_classes: ["XCTestCase"]

## Non Triggering Examples

```swift
class TestCase: XCTestCase {
  var api: API!
  var data: String? = "data"
  override func setUp() {
    super.setUp()
    api = API()
    api.data = data
  }
  override func tearDown() {
    api = nil
    data = nil
    super.tearDown()
  }
}
```

## Triggering Examples

```swift
class TestCase: XCTestCase {
  var ↓api: API!
  var data: String? = "data"
  override func setUp() {
    super.setUp()
    api = API()
  }
  override func tearDown() {
    data = nil
    super.tearDown()
  }
}
```

```swift
class TestCase: XCTestCase {
  var ↓api: API!
  var ↓data: String? = "data"
  override func setUp() {
    super.setUp()
    api = API()
  }
}
```

```swift
class TestCase: XCTestCase {
  var ↓api: API!
  var data: String? = "data"
  let ↓config = Config()
  override func tearDown() {
    data = nil
    super.tearDown()
  }
}
```