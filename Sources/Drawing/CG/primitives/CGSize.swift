extension CGSize: Real2D {
    @inlinable public var tuple: (CGFloat, CGFloat) { (width, height) }
    @inlinable public init(_ tuple: (CGFloat, CGFloat)) { self.init(width: tuple.0, height: tuple.1) }
}

extension CGSize {
    @inlinable public init(square length: CGFloat) { self.init(width: length, height: length) }
}

extension CGSize {
    @inlinable public var area: CGFloat { width * height }
}

extension CGSize {
    
    @inlinable public func randomPoint() -> CGPoint {
        .init(
            x: .random(in: width < 0 ? width ... 0 : 0 ... width),
            y: .random(in: height < 0 ? height ... 0 : 0 ... height)
        )
    }
}