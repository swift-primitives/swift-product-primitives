// Product+Hash.Protocol.swift
// Conformance of Product to Hash.Protocol.
//
// On Swift <6.4, `Hash.Protocol` is the institute fork supporting
// `borrowing self`; it refines `Equation.Protocol`, NOT `Swift.Hashable`,
// so this extension carries the borrowing `hash(into:)` witness and is
// constrained on `Hash.Protocol` elements (the stdlib-integration module
// provides `Int: Hash.Protocol` etc. on <6.4).
//
// On Swift 6.4+, `Hash.Protocol` REFINES `Swift.Hashable` (re-declaring a
// typed `hashValue: Hash.Value`, defaulted in hash-primitives). Two things
// changed upstream that force a different shape here:
//   1. A conditional conformance to a refining protocol no longer implies the
//      refined (`Swift.Hashable`) conformance — that is declared separately in
//      `Product+Hashable.swift`.
//   2. `Hash Primitives Standard Library Integration` gates its scalar
//      conformances (`Int: Hash.Protocol`, …) to `#if swift(<6.4)`, so on 6.4
//      stdlib scalars satisfy `Swift.Hashable` but NOT `Hash.Protocol`.
// Constraining this conformance on `each Element: Swift.Hashable` (rather than
// `Hash.Protocol`) therefore keeps `Product<Int, String, …>` a `Hash.Protocol`
// conformer on 6.4 exactly as it was on 6.3 — preserving source compatibility.
// It is sound because on 6.4 `Hash.Protocol` adds only the defaulted
// `hashValue: Hash.Value` over `Swift.Hashable`; the `hash(into:)` witness is
// inherited from the `Swift.Hashable` conformance in `Product+Hashable.swift`.

#if swift(<6.4)
extension Product: Hash.`Protocol` where repeat each Element: Hash.`Protocol` {
    /// Feeds each component into the given hasher in pack order.
    @inlinable
    @_disfavoredOverload
    public borrowing func hash(into hasher: inout Hasher) {
        func combine<T: Hash.`Protocol`>(_ x: borrowing T, into hasher: inout Hasher) {
            x.hash(into: &hasher)
        }
        repeat combine(each values, into: &hasher)
    }
}
#else
extension Product: Hash.`Protocol` where repeat each Element: Swift.Hashable {}
#endif
