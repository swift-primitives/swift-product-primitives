#if !hasFeature(Embedded)
    // swiftlint:disable no_any_protocol_existential
    // reason: stdlib protocol witness — Decodable.init(from:) signature mandates the existential
    // shape; the untyped throws clause mirrors the protocol requirement. [API-ERR-006] exception.
    extension Product: Decodable where repeat each Element: Decodable {
        /// Decodes each component from an unkeyed container in pack order.
        ///
        /// The error type is the stdlib's open `Swift.Error` because the protocol
        /// requirement `Decodable.init(from:) throws` is itself untyped; downstream
        /// errors propagate from `UnkeyedDecodingContainer.decode(_:)`.
        @inlinable
        public init(from decoder: any Decoder) throws(any Swift.Error) {
            var container = try decoder.unkeyedContainer()
            self.init(repeat try container.decode((each Element).self))
        }
    }
    // swiftlint:enable no_any_protocol_existential
#endif
