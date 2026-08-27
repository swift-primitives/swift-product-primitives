public import Product

extension Product: CustomStringConvertible
where repeat each Element: CustomStringConvertible {

    @inlinable
    public var description: String {
        var parts: [String] = []
        for desc in repeat (each values).description {
            parts.append(desc)
        }
        return "(\(parts.joined(separator: ", ")))"
    }
}
