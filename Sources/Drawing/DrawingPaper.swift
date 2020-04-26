public protocol DrawingPaper: AnyObject {
    
    func draw<Stroke: StrokeInSpace>(_: Stroke) where Stroke.D: BinaryFloatingPoint
    
    // transform:
    // func draw<D: Drawing>(_ drawing: D, using: AffineTransform)
    
    // TODO: add default implementations for shapes
    // func draw<Rectangle: RectangleInSpace>(_: Rectangle)
    func draw<Ellipse: EllipseInSpace>(_: Ellipse) where Ellipse.D: BinaryFloatingPoint
}



