extension CGContext: CGPencil {
    
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
        if o.isClosed { closePath() }
    }
    
    public func draw(_ drawing: CGDrawing, using t: CGAffineTransform = .identity) {
        let o = CGMutablePath()
        o.addPath(drawing.path(), transform: t)
        addPath(o)
    }
    
    public func draw(_ o: CGPolygonalChain) {
        addLines(between: o.vertices)
        if !o.isEmpty, o.isClosed { closePath() }
    }
    
    public func draw(_ o: CGRect) {
        addRect(o)
    }
    
    public func draw(_ o: CGEllipse) {
        addEllipse(in: o.frame)
    }
}

extension CGContext {
    @inlinable public var size: CGSize { .init(width: width.cg, height: height.cg) }
    @inlinable public var bounds: CGRect { .init(origin: .zero, size: size) }
}

extension CGContext {
    
    @inlinable public static func rgb(width: Int, height: Int) throws -> CGContext {
        return try CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        .or(throw: "⚠️ Could not create CGContext(width: \(width), height: \(height)".error())
    }
    
    @inlinable public static func rgb(
        preferredSize: CGSize,
        padding: CGFloat = 0,
        scale: CGFloat = 1
    ) throws -> CGContext {
        try rgb(preferredSize: preferredSize, padding: .init(square: padding), scale: scale)
    }
    
    @inlinable public static func rgb(
        preferredSize: CGSize,
        padding: CGSize,
        scale: CGFloat = 1
    ) throws -> CGContext {
        let bounds = CGRect(
            origin: .zero,
            size: (preferredSize + padding * 2) * scale
        ).integral
        let o = try rgb(width: bounds.size.width.i, height: bounds.size.height.i)
        o.scaleBy(x: scale, y: scale)
        o.translateBy(x: padding.width, y: padding.height)
        return o
    }
}
