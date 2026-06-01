// Product+Hash.Protocol.swift
// Conformance of Product to Hash.Protocol — unconditional.
//
// On Swift <6.4, `Hash.Protocol` is the institute fork supporting
// `borrowing self`. On Swift 6.4+, it is a typealias to `Swift.Hashable`
// per SE-0499 — this same extension then satisfies the stdlib conformance
// directly. The stdlib `Product: Hashable` extension in
// `Product+Hashable.swift` is therefore guarded `#if swift(<6.4)` to avoid
// duplicate-conformance.

extension Product: Hash.`Protocol` where repeat each Element: Hash.`Protocol` {
    /// Feeds each component into the given hasher in pack order.
    ///
    /// On Swift <6.4 this provides the borrowing-self `hash(into:)` for the
    /// institute fork. On Swift 6.4+ it is the `hash(into:)` witness for the
    /// explicit `Swift.Hashable` conformance below (the typed `hashValue` is
    /// defaulted in hash-primitives).
    @inlinable
    @_disfavoredOverload
    public borrowing func hash(into hasher: inout Hasher) {
        func combine<T: Hash.`Protocol`>(_ x: borrowing T, into hasher: inout Hasher) {
            x.hash(into: &hasher)
        }
        repeat combine(each values, into: &hasher)
    }
}

// Swift 6.4+: `Hash.Protocol` REFINES `Swift.Hashable`; a conditional conformance to it
// does not synthesize the inherited `Swift.Hashable`, so declare it explicitly. The
// `hash(into:)` witness above satisfies it. `Equatable` comes from the sibling
// `Equation.Protocol` conformance. Ref: Research/se-0499-…md Addendum (2026-06-01).
#if swift(>=6.4)
extension Product: Swift.Hashable where repeat each Element: Hash.`Protocol` {}
#endif
