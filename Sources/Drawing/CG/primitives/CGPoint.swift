extension CGPoint: Real2D {
    @inlinable public var tuple: (CGFloat, CGFloat) { (x, y) }
    @inlinable public init(_ tuple: (CGFloat, CGFloat)) { self.init(x: tuple.0, y: tuple.1) }
}

extension CGPoint {
    @inlinable public func angle(to other: Self) -> CGFloat { (other - self).direction() }
    @inlinable public func distance(to other: Self) -> CGFloat { (other - self).magnitude() }
}

extension CGPoint {
    
    @inlinable public func point(at angle: CGFloat, distance: CGFloat) -> CGPoint {
        .init(x: cos(angle) * distance + x, y: sin(angle) * distance + y)
    }
    
    public mutating func apply(_ t: CGAffineTransform) {
        self = self.applying(t)
    }
}

extension CGPoint {
    @inlinable public func circle(radius: CGFloat) -> CGCircle { .init(center: self, radius: radius) }
    @inlinable public func dot(radius: CGFloat = 1) -> CGCircle { circle(radius: radius) }
}

extension CGPoint {
    
    @inlinable public func rectangle<Anchor>(size: CGSize, anchor: Anchor) -> CGRect where Anchor: Real2D, Anchor.D == CGFloat {
        .init(origin: self - size * anchor, size: size)
    }
    
    @inlinable public func rectangle(size: CGSize) -> CGRect {
        rectangle(size: size, anchor: CGPoint.unit / 2)
    }
}

extension Sequence where Element == CGPoint {
    
    @inlinable public func dots(radius: CGFloat = 1) -> [CGCircle] {
        map{ $0.dot(radius: radius) }
    }
}

