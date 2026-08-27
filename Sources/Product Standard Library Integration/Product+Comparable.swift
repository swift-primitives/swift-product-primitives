public import Product

extension Product: Swift.Comparable where repeat each Element: Swift.Comparable {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        var result = false
        var decided = false
        func compare<T: Swift.Comparable>(_ l: T, _ r: T) {
            guard !decided else { return }
            if l < r {
                result = true
                decided = true
            } else if r < l {
                result = false
                decided = true
            }
        }
        repeat compare(each lhs.values, each rhs.values)
        return result
    }
}
