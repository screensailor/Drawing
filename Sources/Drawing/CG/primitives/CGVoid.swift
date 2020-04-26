public struct CGVoid: Codable, Equatable {
    public init() {}
}

extension CGVoid: CGDrawing {
    
    public func draw(with pencil: CGPencil) {}
}
