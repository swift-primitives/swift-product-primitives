# Product

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

`Product<each Element>` — the n-ary cartesian product type, a named wrapper around Swift parameter-pack tuples with key-path-driven dynamic member lookup. Where `Pair` is the binary product, `Product` is its variadic generalization.

Conditionally `Sendable` / `Equatable` / `Hashable` / `Comparable` / `CustomStringConvertible` / `Encodable` / `Decodable` based on its components, and conforms to `Swift.Error` when every component is itself an `Error` — useful for typed multi-cause error aggregation.

---

## Quick Start

```swift
import Product

let pair = Product(1, "hello")           // Product<Int, String>
let triple = Product(1, "hello", true)   // Product<Int, String, Bool>

print(pair.values.0)    // 1
print(pair.0)           // 1 (via dynamic member lookup)

let a = Product(1, "x", true)
let b = Product(1, "x", true)
a == b                              // true (Equatable for any Equatable elements)

let p = Product(1, "abc")
p < Product(1, "abd")               // true — lexicographic; requires every element be Comparable
String(describing: triple)          // "(1, hello, true)"
```

### Transforming components

Total transform — one closure per position, any arity. Pass identity (`{ $0 }`) for positions you want to leave unchanged:

```swift
let triple = Product(1, "hi", true)

let mapped = triple.map(
    { $0 + 1 },
    { $0.uppercased() },
    { !$0 }
)
// Product<Int, String, Bool> = (2, "HI", false)

let firstOnly = triple.map({ $0 + 10 }, { $0 }, { $0 })
// Product<Int, String, Bool> = (11, "hi", true)
```

### Composing pack shapes

```swift
let pair = Product(1, "hi")
pair.append(true)             // Product<Int, String, Bool>
pair.prepend(0.5)             // Product<Double, Int, String>

let a = Product(1, "x")
let b = Product(true, 0.5)
a.zip(b)                      // Product<(Int, Bool), (String, Double)>

triple.fold { (a, b, c) in "\(a) \(b) \(c)" }   // "1 hi true"
swapped(pair)                                    // Product<String, Int>
```

### Multi-cause typed errors

```swift
enum Parse      { struct Error: Swift.Error {} }
enum Validation { struct Error: Swift.Error {} }

func process() throws(Product<Parse.Error, Validation.Error>) {
    // throw an aggregated cause...
}
```

### Lifecycle and ~Escapable arms

`Product` is a *movement vehicle* — it transports its components as one
unit. It does not close, unlock, or otherwise act on its components on
drop; lifecycle decisions belong to the consumer.

`Product`'s arms are currently `Copyable` and `Escapable` only. Parameter-
pack syntax does not yet admit `each T: ~Copyable` or `each T: ~Escapable`,
so the cohort siblings `Pair` and `Either` admit `~Escapable` arms while
`Product` does not. Revisit when Swift's parameter-pack support extends to
suppressed conformances; until then, consumers needing `~Escapable` arms
in arity-2 use `Pair`.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-atoms/swift-product.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Product", package: "swift-product"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

One library product, one target.

| Product | Target | Contents |
|---------|--------|----------|
| `Product` | `Sources/Product/` | `Product<each Element>` (variadic over parameter packs) + dynamic-member-lookup subscript + `map` / `append` / `prepend` / `zip` / `fold` instance methods + free `swapped(_:)` for n=2 + conditional `Sendable` / `Equatable` / `Hashable` / `Comparable` / `CustomStringConvertible` / `Encodable` / `Decodable` / `Swift.Error` conformances. |

Conditional `Equation.Protocol`, `Hash.Protocol`, and `Comparison.Protocol` conformances are gated `#if swift(<6.4)` per SE-0499; under Swift 6.4+, those institute protocols are typealiases to the stdlib counterparts and the existing stdlib conformances satisfy them automatically.

Dependencies: `swift-comparison`, `swift-equation`, `swift-hash`. Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |
| Swift Embedded | Supported |

---

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
