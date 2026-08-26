@inlinable
public func swapped<First, Second>(
    _ product: consuming Product<First, Second>
) -> Product<Second, First> {
    let values = (consume product).values
    return Product(values.1, values.0)
}
