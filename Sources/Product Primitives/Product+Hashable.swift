// Product+Hashable.swift
// Swift.Hashable conformance — unconditional, constrained on Swift.Hashable.

extension Product: Swift.Hashable where repeat each Element: Swift.Hashable {
    /// Feeds each component into the given hasher in pack order.
    @inlinable
    public func hash(into hasher: inout Hasher) {
        func combine<T: Swift.Hashable>(_ x: T, into hasher: inout Hasher) {
            hasher.combine(x)
        }
        repeat combine(each values, into: &hasher)
    }
}
