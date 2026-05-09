// Stdlib Equatable conformance is gated `#if swift(<6.4)` only. On Swift
// 6.4+ `Equation.Protocol === Swift.Equatable` per SE-0499, and the
// unconditional `Product: Equation.Protocol` extension in
// `Product+Equation.Protocol.swift` IS the stdlib conformance — declaring
// an additional stdlib extension here would trigger duplicate-conformance.
// Pattern matches swift-pair-primitives / swift-either-primitives.

#if swift(<6.4)
    extension Product: Equatable where repeat each Element: Equatable {
        /// Returns `true` when both products' components are pair-wise equal.
        @inlinable
        public static func == (lhs: Self, rhs: Self) -> Bool {
            func eq<T: Equatable>(_ a: T, _ b: T) -> Bool { a == b }
            for r in repeat eq(each lhs.values, each rhs.values) {
                if !r { return false }
            }
            return true
        }
    }
#endif
