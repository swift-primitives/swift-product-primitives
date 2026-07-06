// Product+Hashable.swift
// Swift.Hashable conformance — unconditional, constrained on Swift.Hashable.
//
// Constrained on the STDLIB bound (`each Element: Swift.Hashable`), NOT on
// `Hash.Protocol`, so that products of stdlib-hashable elements (Int, String,
// …) are `Swift.Hashable` on every toolchain. On Swift 6.4+ `Hash.Protocol`
// REFINES `Swift.Hashable` and no longer auto-implies it for conditional
// conformers, and the `Hash Primitives Standard Library Integration` module
// gates `Int: Hash.Protocol` to `#if swift(<6.4)`; constraining this
// conformance on `Hash.Protocol` would therefore make `Product<Int, …>` stop
// being `Hashable` on 6.4 (a source break). This extension also supplies the
// `hash(into:)` witness reused by the `Hash.Protocol` conformance on 6.4+.
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
