struct Pair<T1, T2> {
    let first: T1
    let second: T2
    
    init(_ first: T1, _ second: T2) {
        self.first = first
        self.second = second
    }
}

extension Pair: Equatable where T1: Equatable, T2: Equatable {
    static func ==(lhs: Pair, rhs: Pair) -> Bool {
        return lhs.first == rhs.first && lhs.second == rhs.second
    }
}

extension Pair: Hashable where T1: Hashable, T2: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(first)
        hasher.combine(second)
    }
}

extension Pair: CustomDebugStringConvertible {
    var debugDescription: String {
        "(\(self.first), \(self.second))"
    }
}
