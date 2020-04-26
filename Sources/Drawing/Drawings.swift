extension Array where Element == Drawing {
    
    @inlinable public func draw<Paper>(on paper: Paper) where Paper: DrawingPaper {
        reversed().forEach{ $0.draw(on: paper) }
    }
}

public func + (l: Drawing, r: Drawing) -> Drawing {
    switch (l, r) {
    case let (l as [Drawing], r as [Drawing]): return l + r
    case let (l as [Drawing], r): return l + [r]
    case let (l, r as [Drawing]): return [l] + r
    case let (l, r): return [l, r]
    }
}
