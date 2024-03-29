# Collection Element Alignment

All elements in a collection literal should be vertically aligned

* **Identifier:** collection_alignment
* **Enabled by default:** No
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** severity: warning, align_colons: false

## Non Triggering Examples

```swift
doThings(arg: [
    "foo": 1,
    "bar": 2,
    "fizz": 2,
    "buzz": 2
])
```

```swift
let abc = [
    "alpha": "a",
    "beta": "b",
    "gamma": "g",
    "delta": "d",
    "epsilon": "e"
]
```

```swift
let meals = [
                "breakfast": "oatmeal",
                "lunch": "sandwich",
                "dinner": "burger"
]
```

```swift
let coordinates = [
    CLLocationCoordinate2D(latitude: 0, longitude: 33),
    CLLocationCoordinate2D(latitude: 0, longitude: 66),
    CLLocationCoordinate2D(latitude: 0, longitude: 99)
]
```

```swift
var evenNumbers: Set<Int> = [
    2,
    4,
    6
]
```

```swift
let abc = [1, 2, 3, 4]
```

```swift
let abc = [
    1, 2, 3, 4
]
```

```swift
let abc = [
    "foo": "bar", "fizz": "buzz"
]
```

## Triggering Examples

```swift
doThings(arg: [
    "foo": 1,
    "bar": 2,
   ↓"fizz": 2,
   ↓"buzz": 2
])
```

```swift
let abc = [
    "alpha": "a",
     ↓"beta": "b",
    "gamma": "g",
    "delta": "d",
  ↓"epsilon": "e"
]
```

```swift
let meals = [
                "breakfast": "oatmeal",
                "lunch": "sandwich",
    ↓"dinner": "burger"
]
```

```swift
let coordinates = [
    CLLocationCoordinate2D(latitude: 0, longitude: 33),
        ↓CLLocationCoordinate2D(latitude: 0, longitude: 66),
    CLLocationCoordinate2D(latitude: 0, longitude: 99)
]
```

```swift
var evenNumbers: Set<Int> = [
    2,
  ↓4,
    6
]
```