public struct CGLineSegment: Codable, Equatable {
    public var start: CGPoint
    public var end: CGPoint
}

extension CGLineSegment {
    
    public init(from start: CGPoint, to end: CGPoint) {
        self.start = start
        self.end = end
    }
}

extension CGLineSegment {
    @inlinable public func angle() -> CGFloat { start.angle(to: end) }
    @inlinable public func length() -> CGFloat { start.distance(to: end) }
    @inlinable public func slope() -> CGFloat { (end.y - start.y) / (end.x - start.x) }
    @inlinable public func xIntercept() -> CGFloat { -yIntercept() / slope() }
    @inlinable public func yIntercept() -> CGFloat { end.y - slope() * end.x }
}

extension CGLineSegment {
    
    public func intersection(with other: CGLineSegment) -> CGPoint? {
        let (a, b, c, d) = (slope(), yIntercept(), other.slope(), other.yIntercept())
        let x: CGFloat, s: CGFloat, i: CGFloat
        switch (a.isFinite, c.isFinite) {
        case (false, false): return nil
        case (true, true): (x, s, i) = ((d - b) / (a - c), a, b)
        case (false, true): (x, s, i) = (start.x, c, d)
        case (true, false): (x, s, i) = (other.start.x, a, b)
        }
        let y = s * x + i
        guard
            x.isFinite, y.isFinite,
            x.isBetween(start.x, and: end.x),
            y.isBetween(start.y, and: end.y),
            x.isBetween(other.start.x, and: other.end.x),
            y.isBetween(other.start.y, and: other.end.y)
            else
        { return nil }
        return .init(x: x, y: y)
    }
}

extension CGLineSegment {
    
    @inlinable public func applying(_ t: CGAffineTransform) -> CGLineSegment {
        .init(from: start.applying(t), to: end.applying(t))
    }
}

extension CGLineSegment {
    
    @inlinable public func reflect<Points>(_ points: Points) -> [CGPoint]
        where Points: Sequence, Points.Element == CGPoint
    {
        let t = reflection()
        return points.map(t.transform)
    }
    
    @inlinable public func reflect(_ point: CGPoint) -> CGPoint {
        point.applying(reflection())
    }

    public func reflection() -> CGAffineTransform {
        guard let s = slope().ifFinite else {
            return CGAffineTransform(
                a: -1, b: 0,
                c: 0, d: 1,
                tx: 2 * end.x, ty: 0
            )
        }
        let c = yIntercept()
        let a = 1 - s * s
        let b = 1 + s * s
        let m1 = a / b
        let m2 = 2 * s / b
        return CGAffineTransform(
            a: m1, b: m2,
            c: m2, d: -m1,
            tx: -2 * s * c / b, ty: 2 * c / b
        )
    }
}

extension CGLineSegment: CGDrawing {
    
    @inlinable public func draw(with pencil: CGPencil) {
        pencil.draw(.init(start, [end], closed: false))
    }
    
    @inlinable public var debugDescription: String {
        "\(CGLineSegment.self)(start: \(start), end: \(end))"
    }
}
