# Contains over First not Nil

Prefer `contains` over `first(where:) != nil` and `firstIndex(where:) != nil`.

* **Identifier:** contains_over_first_not_nil
* **Enabled by default:** No
* **Supports autocorrection:** No
* **Kind:** performance
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let first = myList.first(where: { $0 % 2 == 0 })

```

```swift
let first = myList.first { $0 % 2 == 0 }

```

```swift
let firstIndex = myList.firstIndex(where: { $0 % 2 == 0 })

```

```swift
let firstIndex = myList.firstIndex { $0 % 2 == 0 }

```

## Triggering Examples

```swift
↓myList.first { $0 % 2 == 0 } != nil

```

```swift
↓myList.first(where: { $0 % 2 == 0 }) != nil

```

```swift
↓myList.map { $0 + 1 }.first(where: { $0 % 2 == 0 }) != nil

```

```swift
↓myList.first(where: someFunction) != nil

```

```swift
↓myList.map { $0 + 1 }.first { $0 % 2 == 0 } != nil

```

```swift
(↓myList.first { $0 % 2 == 0 }) != nil

```

```swift
↓myList.first { $0 % 2 == 0 } == nil

```

```swift
↓myList.first(where: { $0 % 2 == 0 }) == nil

```

```swift
↓myList.map { $0 + 1 }.first(where: { $0 % 2 == 0 }) == nil

```

```swift
↓myList.first(where: someFunction) == nil

```

```swift
↓myList.map { $0 + 1 }.first { $0 % 2 == 0 } == nil

```

```swift
(↓myList.first { $0 % 2 == 0 }) == nil

```

```swift
↓myList.firstIndex { $0 % 2 == 0 } != nil

```

```swift
↓myList.firstIndex(where: { $0 % 2 == 0 }) != nil

```

```swift
↓myList.map { $0 + 1 }.firstIndex(where: { $0 % 2 == 0 }) != nil

```

```swift
↓myList.firstIndex(where: someFunction) != nil

```

```swift
↓myList.map { $0 + 1 }.firstIndex { $0 % 2 == 0 } != nil

```

```swift
(↓myList.firstIndex { $0 % 2 == 0 }) != nil

```

```swift
↓myList.firstIndex { $0 % 2 == 0 } == nil

```

```swift
↓myList.firstIndex(where: { $0 % 2 == 0 }) == nil

```

```swift
↓myList.map { $0 + 1 }.firstIndex(where: { $0 % 2 == 0 }) == nil

```

```swift
↓myList.firstIndex(where: someFunction) == nil

```

```swift
↓myList.map { $0 + 1 }.firstIndex { $0 % 2 == 0 } == nil

```

```swift
(↓myList.firstIndex { $0 % 2 == 0 }) == nil

```