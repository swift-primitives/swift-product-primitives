#if !hasFeature(Embedded)
    // swiftlint:disable no_any_protocol_existential
    // reason: stdlib protocol witness — Encodable.encode(to:) signature mandates the existential
    // shape; the untyped throws clause mirrors the protocol requirement. [API-ERR-006] exception.
    extension Product: Encodable where repeat each Element: Encodable {
        /// Encodes each component into an unkeyed container in pack order.
        ///
        /// The error type is the stdlib's open `Swift.Error` because the protocol
        /// requirement `Encodable.encode(to:) throws` is itself untyped; downstream
        /// errors propagate from `UnkeyedEncodingContainer.encode(_:)`.
        @inlinable
        public func encode(to encoder: any Encoder) throws(any Swift.Error) {
            var container = encoder.unkeyedContainer()
            for value in repeat each values {
                try container.encode(value)
            }
        }
    }
// swiftlint:enable no_any_protocol_existential
#endif
