# Generic Type Name

Generic type name should only contain alphanumeric characters, start with an uppercase character and span between 1 and 20 characters in length.

* **Identifier:** generic_type_name
* **Enabled by default:** Yes
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** (min_length) w/e: 1/0, (max_length) w/e: 20/1000, excluded: [], allowed_symbols: [], validates_start_with_lowercase: error

## Non Triggering Examples

```swift
func foo<T>() {}

```

```swift
func foo<T>() -> T {}

```

```swift
func foo<T, U>(param: U) -> T {}

```

```swift
func foo<T: Hashable, U: Rule>(param: U) -> T {}

```

```swift
struct Foo<T> {}

```

```swift
class Foo<T> {}

```

```swift
enum Foo<T> {}

```

```swift
func run(_ options: NoOptions<CommandantError<()>>) {}

```

```swift
func foo(_ options: Set<type>) {}

```

```swift
func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool

```

```swift
func configureWith(data: Either<MessageThread, (project: Project, backing: Backing)>)

```

```swift
typealias StringDictionary<T> = Dictionary<String, T>

```

```swift
typealias BackwardTriple<T1, T2, T3> = (T3, T2, T1)

```

```swift
typealias DictionaryOfStrings<T : Hashable> = Dictionary<T, String>

```

## Triggering Examples

```swift
func foo<↓T_Foo>() {}

```

```swift
func foo<T, ↓U_Foo>(param: U_Foo) -> T {}

```

```swift
func foo<↓TTTTTTTTTTTTTTTTTTTTT>() {}

```

```swift
func foo<↓type>() {}

```

```swift
typealias StringDictionary<↓T_Foo> = Dictionary<String, T_Foo>

```

```swift
typealias BackwardTriple<T1, ↓T2_Bar, T3> = (T3, T2_Bar, T1)

```

```swift
typealias DictionaryOfStrings<↓T_Foo: Hashable> = Dictionary<T_Foo, String>

```

```swift
class Foo<↓T_Foo> {}

```

```swift
class Foo<T, ↓U_Foo> {}

```

```swift
class Foo<↓T_Foo, ↓U_Foo> {}

```

```swift
class Foo<↓TTTTTTTTTTTTTTTTTTTTT> {}

```

```swift
class Foo<↓type> {}

```

```swift
struct Foo<↓T_Foo> {}

```

```swift
struct Foo<T, ↓U_Foo> {}

```

```swift
struct Foo<↓T_Foo, ↓U_Foo> {}

```

```swift
struct Foo<↓TTTTTTTTTTTTTTTTTTTTT> {}

```

```swift
struct Foo<↓type> {}

```

```swift
enum Foo<↓T_Foo> {}

```

```swift
enum Foo<T, ↓U_Foo> {}

```

```swift
enum Foo<↓T_Foo, ↓U_Foo> {}

```

```swift
enum Foo<↓TTTTTTTTTTTTTTTTTTTTT> {}

```

```swift
enum Foo<↓type> {}

```