// Product+Equation.Protocol.swift
// Conformance of Product to Equation.Protocol — unconditional.
//
// On Swift <6.4, `Equation.Protocol` is the institute fork supporting
// `borrowing` parameters. On Swift 6.4+, it is a typealias to
// `Swift.Equatable` per SE-0499 — this same extension then satisfies the
// stdlib conformance directly. The stdlib `Product: Equatable` extension
// in `Product+Equatable.swift` is therefore guarded `#if swift(<6.4)` to
// avoid duplicate-conformance.

extension Product: Equation.`Protocol` where repeat each Element: Equation.`Protocol` {
    /// Returns `true` when both products' components are pair-wise equal.
    ///
    /// On Swift <6.4 this provides the borrowing-parameter `==` for the
    /// institute fork; on Swift 6.4+ it provides the stdlib `Equatable`
    /// conformance directly via the SE-0499 typealias.
    @inlinable
    @_disfavoredOverload
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        func eq<T: Equation.`Protocol`>(_ a: borrowing T, _ b: borrowing T) -> Bool {
            a == b
        }
        for r in repeat eq(each lhs.values, each rhs.values) {
            if !r { return false }
        }
        return true
    }
}
