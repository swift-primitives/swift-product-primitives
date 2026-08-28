extension Product: Comparison::Comparison.`Protocol`
where repeat each Element: Comparison::Comparison.`Protocol` {

    @inlinable
    @_disfavoredOverload
    public static func < (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        func cmp<T: Comparison::Comparison.`Protocol`>(
            _ a: borrowing T,
            _ b: borrowing T
        ) -> Comparison::Comparison {
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
