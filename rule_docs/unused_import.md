# Unused Import

All imported modules should be required to make the file compile

* **Identifier:** unused_import
* **Enabled by default:** No
* **Supports autocorrection:** Yes
* **Kind:** lint
* **Analyzer rule:** Yes
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** severity: warning, require_explicit_imports: false, allowed_transitive_imports: [], always_keep_imports: []

## Non Triggering Examples

```swift
import Dispatch // This is used
dispatchMain()
```

```swift
@testable import Dispatch
dispatchMain()
```

```swift
import Foundation
@objc
class A {}
```

```swift
import UnknownModule
func foo(error: Swift.Error) {}
```

```swift
import Foundation
let 👨‍👩‍👧‍👦 = #selector(NSArray.contains(_:))
👨‍👩‍👧‍👦 == 👨‍👩‍👧‍👦
```

## Triggering Examples

```swift
↓import Dispatch
struct A {
  static func dispatchMain() {}
}
A.dispatchMain()
```

```swift
↓import Foundation // This is unused
struct A {
  static func dispatchMain() {}
}
A.dispatchMain()
↓import Dispatch

```

```swift
↓import Foundation
dispatchMain()
```

```swift
↓import Foundation
// @objc
class A {}
```

```swift
↓import Foundation
import UnknownModule
func foo(error: Swift.Error) {}
```

```swift
↓import Swift
↓import SwiftShims
func foo(error: Swift.Error) {}
```