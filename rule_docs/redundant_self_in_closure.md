# Redundant Self in Closure

Explicit use of 'self' is not required

* **Identifier:** redundant_self_in_closure
* **Enabled by default:** No
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
    struct S {
        var x = 0
        func f(_ work: @escaping () -> Void) { work() }
        func g() {
            f {
                x = 1
                f { x = 1 }
                g()
            }
        }
    }
```

```swift
    class C {
        var x = 0
        func f(_ work: @escaping () -> Void) { work() }
        func g() {
            f { [weak self] in
                self?.x = 1
                self?.g()
                guard let self = self ?? C() else { return }
                self?.x = 1
            }
            C().f { self.x = 1 }
            f { [weak self] in if let self { x = 1 } }
        }
    }
```

```swift
    struct S {
        var x = 0
        func f(_ work: @escaping () -> Void) { work() }
        func g(x: Int) {
            f { self.x = x }
        }
    }
```

## Triggering Examples

```swift
    struct S {
        var x = 0
        func f(_ work: @escaping () -> Void) { work() }
        func g() {
            f {
                ↓self.x = 1
                if ↓self.x == 1 { ↓self.g() }
            }
        }
    }
```

```swift
    class C {
        var x = 0
        func g() {
            {
                ↓self.x = 1
                ↓self.g()
            }()
        }
    }
```

```swift
    class C {
        var x = 0
        func f(_ work: @escaping () -> Void) { work() }
        func g() {
            f { [self] in
                ↓self.x = 1
                ↓self.g()
                f { self.x = 1 }
            }
        }
    }
```

```swift
    class C {
        var x = 0
        func f(_ work: @escaping () -> Void) { work() }
        func g() {
            f { [unowned self] in ↓self.x = 1 }
            f { [self = self] in ↓self.x = 1 }
            f { [s = self] in s.x = 1 }
        }
    }
```