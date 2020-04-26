@_exported import CoreGraphics
@_exported import Space

public protocol CGDrawing: CustomPlaygroundDisplayConvertible {
    func draw(with pencil: CGPencil)
}

extension CGDrawing {
    
    public var playgroundDescription: Any {
        #if canImport(AppKit)
        return path().playgroundDescription
        #else
        return "TODO" + here()
        #endif
    }
}
