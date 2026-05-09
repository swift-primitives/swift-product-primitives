// Stdlib Hashable conformance is gated `#if swift(<6.4)` only. On Swift
// 6.4+ `Hash.Protocol === Swift.Hashable` per SE-0499, and the
// unconditional `Product: Hash.Protocol` extension in
// `Product+Hash.Protocol.swift` IS the stdlib conformance.

#if swift(<6.4)
    extension Product: Hashable where repeat each Element: Hashable {
        /// Feeds each component into the given hasher in pack order.
        @inlinable
        public func hash(into hasher: inout Hasher) {
            func combine<T: Hashable>(_ x: T, into hasher: inout Hasher) {
                hasher.combine(x)
            }
            repeat combine(each values, into: &hasher)
        }
    }
#endif
