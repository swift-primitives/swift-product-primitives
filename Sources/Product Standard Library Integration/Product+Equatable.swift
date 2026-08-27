public import Product

extension Product: Swift.Equatable where repeat each Element: Swift.Equatable {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        var result = true
        func check<T: Swift.Equatable>(_ l: T, _ r: T) {
            result = result && (l == r)
        }
        repeat check(each lhs.values, each rhs.values)
        return result
    }
}
