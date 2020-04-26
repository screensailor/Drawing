extension CGDrawing {
    
    @inlinable public func path() -> CGMutablePath {
        let o = CGMutablePath()
        draw(with: o)
        return o
    }
}

extension CGMutablePath: CGPencil {
    
    public func draw(_ o: CGStroke) {
        move(to: o.start)
        for o in o.moves {
            switch o.count {
            case 1: addLine(to: o[0])
            case 2: addQuadCurve(to: o[0], control: o[1])
            case 3...: addCurve(to: o[0], control1: o[1], control2: o[2])
            default: continue
            }
        }
        if o.isClosed { closeSubpath() }
    }
    
    public func draw(_ drawing: CGDrawing, using t: CGAffineTransform) {
        addPath(drawing.path(), transform: t)
    }
    
    public func draw(_ o: CGPolygonalChain) {
        addLines(between: o.vertices)
        if !o.isEmpty, o.isClosed { closeSubpath() }
    }
    
    public func draw(_ o: CGRect) {
        addRect(o)
    }
    
    public func draw(_ o: CGEllipse) {
        addEllipse(in: o.frame)
    }
}

