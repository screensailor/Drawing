public protocol CGPencil: AnyObject {
    
    func draw(_: CGStroke)
    func draw(_ drawing: CGDrawing, using: CGAffineTransform)
    
    // TODO: add default implementations:
    func draw(_: CGPolygonalChain)
    func draw(_: CGRect)
    func draw(_: CGEllipse)
}



