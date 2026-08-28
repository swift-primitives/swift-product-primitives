#if !hasFeature(Embedded)

    extension Product: Decodable where repeat each Element: Decodable {

        @inlinable
        public init(from decoder: any Decoder) throws(any Swift.Error) {
            var container = try decoder.unkeyedContainer()
            self.init(repeat try container.decode((each Element).self))
        }
    }

#endif
