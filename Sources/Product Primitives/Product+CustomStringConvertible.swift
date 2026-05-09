extension Product: CustomStringConvertible
where repeat each Element: CustomStringConvertible {
    /// A parenthesized, comma-separated rendering of every component's
    /// `description`, in pack order.
    @inlinable
    public var description: String {
        var parts: [String] = []
        for desc in repeat (each values).description {
            parts.append(desc)
        }
        return "(\(parts.joined(separator: ", ")))"
    }
}
