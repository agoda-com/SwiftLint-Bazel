# Void Return

Prefer `-> Void` over `-> ()`

* **Identifier:** void_return
* **Enabled by default:** Yes
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let abc: () -> Void = {}

```

```swift
let abc: () -> (VoidVoid) = {}

```

```swift
func foo(completion: () -> Void)

```

```swift
let foo: (ConfigurationTests) -> () throws -> Void

```

```swift
let foo: (ConfigurationTests) ->   () throws -> Void

```

```swift
let foo: (ConfigurationTests) ->() throws -> Void

```

```swift
let foo: (ConfigurationTests) -> () -> Void

```

```swift
let foo: () -> () async -> Void

```

```swift
let foo: () -> () async throws -> Void

```

```swift
let foo: () -> () async -> Void

```

```swift
func foo() -> () async throws -> Void {}

```

```swift
func foo() async throws -> () async -> Void { return {} }

```

## Triggering Examples

```swift
let abc: () -> ↓() = {}

```

```swift
let abc: () -> ↓(Void) = {}

```

```swift
let abc: () -> ↓(   Void ) = {}

```

```swift
func foo(completion: () -> ↓())

```

```swift
func foo(completion: () -> ↓(   ))

```

```swift
func foo(completion: () -> ↓(Void))

```

```swift
let foo: (ConfigurationTests) -> () throws -> ↓()

```

```swift
func foo() async -> ↓()

```

```swift
func foo() async throws -> ↓()

```