# Operator Function Whitespace

Operators should be surrounded by a single whitespace when defining them

* **Identifier:** operator_whitespace
* **Enabled by default:** Yes
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
func <| (lhs: Int, rhs: Int) -> Int {}

```

```swift
func <|< <A>(lhs: A, rhs: A) -> A {}

```

```swift
func abc(lhs: Int, rhs: Int) -> Int {}

```

## Triggering Examples

```swift
↓func <|(lhs: Int, rhs: Int) -> Int {}

```

```swift
↓func <|<<A>(lhs: A, rhs: A) -> A {}

```

```swift
↓func <|  (lhs: Int, rhs: Int) -> Int {}

```

```swift
↓func <|<  <A>(lhs: A, rhs: A) -> A {}

```

```swift
↓func  <| (lhs: Int, rhs: Int) -> Int {}

```

```swift
↓func  <|< <A>(lhs: A, rhs: A) -> A {}

```