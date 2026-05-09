// Product+Swap.swift
// Component swap on a binary Product (arity-2 only).
//
// Free function (not a static on `Product`) because Swift's pack inference
// does not bind the enclosing `each Element` from a method's non-pack
// `<First, Second>` generics. A static `Product.swapped<First, Second>(_:)`
// on `Product<repeat each Element>` fails inference at nested call sites
// (`Product.swapped(Product.swapped(pair))`).
//
// For arity-2 work prefer the dedicated `Pair` type, which carries
// `Pair.swapped(_:)` static + `.swapped()` instance forms.

/// Returns a binary Product with components swapped, consuming `product`.
///
/// Free function form: arity-2 only. For arity-2 work prefer the dedicated
/// `Pair` type with its instance `.swapped()` form.
///
/// ```swift
/// let pair = Product(1, "hi")
/// let flipped = swapped(pair)   // Product<String, Int>
/// ```
@inlinable
public func swapped<First, Second>(
    _ product: consuming Product<First, Second>
) -> Product<Second, First> {
    let values = (consume product).values
    return Product(values.1, values.0)
}
