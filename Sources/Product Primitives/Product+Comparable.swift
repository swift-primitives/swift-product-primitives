// Stdlib Comparable conformance is gated `#if swift(<6.4)` only. On Swift
// 6.4+ `Comparison.Protocol === Swift.Comparable` per SE-0499, and the
// unconditional `Product: Comparison.Protocol` extension in
// `Product+Comparison.Protocol.swift` IS the stdlib conformance.

#if swift(<6.4)
    extension Product: Comparable where repeat each Element: Comparable {
        /// Returns `true` when `lhs` precedes `rhs` lexicographically over the
        /// pack of components.
        ///
        /// Iterates the pack and short-circuits at the first non-equal pair.
        @inlinable
        public static func < (lhs: Self, rhs: Self) -> Bool {
            func cmp<T: Comparable>(_ a: T, _ b: T) -> Comparison {
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
#endif
