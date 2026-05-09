#if !hasFeature(Embedded)
    extension Product: Encodable where repeat each Element: Encodable {
        /// Encodes each component into an unkeyed container in pack order.
        ///
        /// The throw type is `any Swift.Error` because the protocol witness
        /// must satisfy `Encodable.encode(to:) throws`, which is itself
        /// untyped; downstream errors propagate from
        /// `UnkeyedEncodingContainer.encode(_:)`.
        @inlinable
        public func encode(to encoder: any Encoder) throws(any Swift.Error) {
            var container = encoder.unkeyedContainer()
            for value in repeat each values {
                try container.encode(value)
            }
        }
    }
#endif
