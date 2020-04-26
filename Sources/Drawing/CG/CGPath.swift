extension Drawing {
    
    @inlinable public func path() -> CGMutablePath {
        let o = CGMutablePath()
        draw(on: o)
        return o
    }
}

extension Ellipse: Drawing, CustomPlaygroundDisplayConvertible where D: BinaryFloatingPoint {}
extension CGEllipse: Drawing, CustomPlaygroundDisplayConvertible {}

extension EllipseInSpace where D: BinaryFloatingPoint {
    public func draw<Paper>(on paper: Paper) where Paper : DrawingPaper {
        paper.draw(self)
    }
}

extension CGMutablePath: DrawingPaper {
    
    public func draw<Stroke: StrokeInSpace>(_ o: Stroke) where Stroke.D: BinaryFloatingPoint {
        move(to: o.start.cast())
        for o in o.moves {
            switch o {
            case let (d, nil): addLine(to: d.cast())
            case let (d, (c1, nil)?): addQuadCurve(to: d.cast(), control: c1.cast())
            case let (d, (c1, c2?)?): addCurve(to: d.cast(), control1: c1.cast(), control2: c2.cast())
            }
        }
        if o.isClosed { closeSubpath() }
    }
    
    public func draw<Ellipse: EllipseInSpace>(_ o: Ellipse) where Ellipse.D: BinaryFloatingPoint {
        addEllipse(in: o.cast(to: CGEllipse.self).frame, transform: .identity)
    }
}

