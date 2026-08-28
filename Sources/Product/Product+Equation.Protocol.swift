extension Product: Equation::Equation.`Protocol`
where repeat each Element: Equation::Equation.`Protocol` {

    @inlinable
    @_disfavoredOverload
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        func eq<T: Equation::Equation.`Protocol`>(_ a: borrowing T, _ b: borrowing T) -> Bool {
            a == b
        }
        for r in repeat eq(each lhs.values, each rhs.values) {
            if !r { return false }
        }
        return true
    }
}
