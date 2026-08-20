// Product+Equation.Protocol.swift
// Conformance of Product to Equation.Protocol — unconditional.

// `Equation.Protocol` aliases `Swift.Equatable`, so this extension also
// supplies the standard-library conformance.

extension Product: Equation.`Protocol` where repeat each Element: Equation.`Protocol` {
    /// Returns `true` when both products' components are pair-wise equal.
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
