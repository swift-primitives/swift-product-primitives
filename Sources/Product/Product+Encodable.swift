#if !hasFeature(Embedded)

    extension Product: Encodable where repeat each Element: Encodable {

        @inlinable
        public func encode(to encoder: any Encoder) throws(any Swift.Error) {
            var container = encoder.unkeyedContainer()
            for value in repeat each values {
                try container.encode(value)
            }
        }
    }

#endif
