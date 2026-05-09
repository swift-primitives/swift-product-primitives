// Product+Comparison.Protocol.swift
// Conformance of Product to Comparison.Protocol — unconditional.
//
// On Swift <6.4, `Comparison.Protocol` is the institute fork supporting
// `borrowing` parameters. On Swift 6.4+, it is a typealias to
// `Swift.Comparable` per SE-0499 — this same extension then satisfies the
// stdlib conformance directly. The stdlib `Product: Comparable` extension
// in `Product+Comparable.swift` is therefore guarded `#if swift(<6.4)` to
// avoid duplicate-conformance.

extension Product: Comparison.`Protocol` where repeat each Element: Comparison.`Protocol` {
    /// Returns `true` when `lhs` precedes `rhs` lexicographically over the
    /// pack of components.
    ///
    /// On Swift <6.4 this provides the borrowing-parameter `<` for the
    /// institute fork; on Swift 6.4+ it provides the stdlib `Comparable`
    /// conformance directly via the SE-0499 typealias.
    @inlinable
    @_disfavoredOverload
    public static func < (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        func cmp<T: Comparison.`Protocol`>(_ a: borrowing T, _ b: borrowing T) -> Comparison {
            if a < b { return .less }
            if a > b { return .greater }
            return .equal
        }
        for order in repeat cmp(each lhs.values, each rhs.values) {
            switch order {
            case .less: return true
            case .greater: return false
            case .equal: continue
            }
        }
        return false
    }
}
