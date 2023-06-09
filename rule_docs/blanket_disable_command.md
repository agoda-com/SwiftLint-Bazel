# Blanket Disable Command

swiftlint:disable commands should be re-enabled before the end of the file

* **Identifier:** blanket_disable_command
* **Enabled by default:** Yes
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** severity: warning, allowed_rules: ["file_header", "file_length", "file_name", "file_name_no_space", "single_test_class"], always_blanket_disable: []

## Non Triggering Examples

```swift
// swiftlint:disable unused_import
// swiftlint:enable unused_import
```

```swift
// swiftlint:disable unused_import unused_declaration
// swiftlint:enable unused_import
// swiftlint:enable unused_declaration
```

```swift
// swiftlint:disable:this unused_import
```

```swift
// swiftlint:disable:next unused_import
```

```swift
// swiftlint:disable:previous unused_import
```

## Triggering Examples

```swift
// swiftlint:disable ↓unused_import
```

```swift
// swiftlint:disable unused_import ↓unused_declaration
// swiftlint:enable unused_import
```

```swift
// swiftlint:disable unused_import
// swiftlint:disable ↓unused_import
// swiftlint:enable unused_import
```

```swift
// swiftlint:enable ↓unused_import
```