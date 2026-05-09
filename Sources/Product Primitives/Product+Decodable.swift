#if !hasFeature(Embedded)
    extension Product: Decodable where repeat each Element: Decodable {
        /// Decodes each component from an unkeyed container in pack order.
        ///
        /// The throw type is `any Swift.Error` because the protocol witness
        /// must satisfy `Decodable.init(from:) throws`, which is itself
        /// untyped; downstream errors propagate from
        /// `UnkeyedDecodingContainer.decode(_:)`.
        @inlinable
        public init(from decoder: any Decoder) throws(any Swift.Error) {
            var container = try decoder.unkeyedContainer()
            self.init(repeat try container.decode((each Element).self))
        }
    }
#endif
