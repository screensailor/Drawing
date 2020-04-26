@_exported import CoreGraphics
@_exported import Space

#if !canImport(AppKit)

public protocol Drawing {
    
    func draw<Paper>(on paper: Paper) where Paper: DrawingPaper
}

extension Array: Drawing where Element == Drawing {}

#else

import AppKit

public protocol Drawing: CustomPlaygroundDisplayConvertible {
    
    func draw<Paper>(on paper: Paper) where Paper: DrawingPaper
}

extension Array: Drawing, CustomPlaygroundDisplayConvertible where Element == Drawing {}

extension Drawing {
    
    public var playgroundDescription: Any {
        if #available(OSX 10.13, *) {
            return path().ns().peek()
        } else {
            return "\(Self.self)"
        }
    }
}

@available(OSX 10.13, *)
extension CGPath {

    public func ns() -> NSBezierPath {
        let path = NSBezierPath()
        applyWithBlock { element in
            let p = element.pointee.points
            switch element.pointee.type
            {
            case .moveToPoint:
                path.move(
                    to: CGPoint(
                        x: p[0].x,
                        y: p[0].y
                    )
                )

            case .addLineToPoint:
                path.line(
                    to: CGPoint(
                        x: p[0].x,
                        y: p[0].y
                    )
                )

            case .addQuadCurveToPoint:
                path.curve(
                    to: CGPoint(x: p[1].x, y: p[1].y),
                    controlPoint1: CGPoint(x: p[0].x, y: p[0].y),
                    controlPoint2: CGPoint(x: p[0].x, y: p[0].y)
                )

            case .addCurveToPoint:
                path.curve(
                    to: CGPoint(x: p[2].x, y: p[2].y),
                    controlPoint1: CGPoint(x: p[0].x, y: p[0].y ),
                    controlPoint2: CGPoint(x: p[1].x, y: p[1].y)
                )

            case .closeSubpath:
                path.close()

            @unknown default:
                assert(false, "The new case \(element.pointee.type) is not handled")
                break
            }
        }
        return path
    }
}
#endif
