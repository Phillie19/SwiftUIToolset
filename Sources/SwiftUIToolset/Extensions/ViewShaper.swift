//
//  File.swift
//
//
//  Created by user on 14.04.2023.
//

import SwiftUI

public extension View {
    func shapped(by shape: ShapeType) -> some View {
       self.clipShape(Shaped(type: shape)).contentShape(Shaped(type: shape))
    }
}

struct Shaped: Shape {
    
    let type: ShapeType

    func path(in rect: CGRect) -> Path {
        switch type {
        case .circle: return Circle().path(in: rect)
        case .capsule: return Capsule().path(in: rect)
        case .rectangle: return Rectangle().path(in: rect)
        case .roundedRectangle(let radius): return RoundedRectangle(cornerRadius: radius).path(in: rect)
        case .roundedCorners(let radius, let corners):
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        case .messageBubble(let radius, let direction):
            return bubblePath(in: rect, radius: radius, direction: direction)
        }
    }
        
    private func bubblePath(in rect: CGRect, radius: CGFloat, direction: Direction) -> Path{
        if direction == .right {
            return rightBubblePath(in: rect, radius: radius)
        } else {
            return leftBubblePath(in: rect, radius: radius)
        }
    }
    
    private func leftBubblePath(in rect: CGRect, radius: CGFloat) -> Path {
        let width = rect.width
        let height = rect.height
        let radius: CGFloat = radius
        var tailOffset: CGFloat {
            radius/4
        }
        
        let path = Path{ p in
            p.move(to: CGPoint(x: tailOffset, y: height - radius))
            
            p.addLine(to: CGPoint(x: tailOffset, y: radius))
            p.addArc(center: CGPoint(x: radius + tailOffset, y: radius), radius: radius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
            p.addLine(to: CGPoint(x: width - radius, y: 0))
            p.addArc(center: CGPoint(x: width - radius, y: radius), radius: radius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
            p.addLine(to: CGPoint(x: width, y: height - radius))
            p.addArc(center: CGPoint(x: width - radius, y: height - radius), radius: radius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
            p.addLine(to: CGPoint(x: tailOffset + radius, y: height))
            p.addCurve(to: CGPoint(x: tailOffset + radius/2, y: height - radius/4),
                       control1: CGPoint(x: tailOffset + radius/4, y: height - radius/4),
                       control2: CGPoint(x: tailOffset + radius/2, y: height - radius/2))
            p.addCurve(to: CGPoint(x: 0, y: height),
                       control1: CGPoint(x: radius/2, y: height),
                       control2: CGPoint(x: tailOffset, y: height))
            p.addCurve(to: CGPoint(x: tailOffset, y: height - radius),
                       control1: CGPoint(x: tailOffset, y: height - radius/4),
                       control2: CGPoint(x: tailOffset, y: height - radius/2))
            
        }
        return path
    }
    
    private func rightBubblePath(in rect: CGRect, radius: CGFloat) -> Path {
        let width = rect.width
        let height = rect.height
        let radius: CGFloat = radius
        var tailOffset: CGFloat {
            radius/4
        }
        
        let path = Path{ p in
            
            p.move(to: CGPoint(x: width - tailOffset, y: height - radius))
            p.addLine(to: CGPoint(x: width - tailOffset, y: radius))
            p.addArc(center: CGPoint(x: width - tailOffset - radius, y: radius), radius: radius, startAngle: .degrees(0), endAngle: .degrees(270), clockwise: true)
            p.addLine(to: CGPoint(x: radius, y: 0))
            p.addArc(center: CGPoint(x: radius, y: radius), radius: radius, startAngle: .degrees(270), endAngle: .degrees(180), clockwise: true)
            p.addLine(to: CGPoint(x: 0, y: height - radius))
            p.addArc(center: CGPoint(x: radius, y: height - radius), radius: radius, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
            p.addLine(to: CGPoint(x: width - radius - tailOffset, y: height))
            p.addCurve(to: CGPoint(x: width - radius/2 - tailOffset, y: height - radius/4),
                       control1: CGPoint(x: width - radius/4 - tailOffset, y: height - radius/4),
                       control2: CGPoint(x: width - radius/2 - tailOffset, y: height - radius/2))
            
            p.addCurve(to: CGPoint(x: width, y: height),
                       control1: CGPoint(x: width - radius/2, y: height),
                       control2: CGPoint(x: width - tailOffset, y: height))
            
            p.addCurve(to: CGPoint(x: width - tailOffset, y: height - radius),
                       control1: CGPoint(x: width - tailOffset, y: height - radius/4),
                       control2: CGPoint(x: width - tailOffset, y: height - radius/2))
        }
        return path
    }

}

public enum ShapeType {
    case circle
    case capsule
    case rectangle
    case roundedRectangle(radius: CGFloat)
    case roundedCorners(radius: CGFloat, corners: UIRectCorner = .allCorners)
    case messageBubble(radius: CGFloat, direction: Direction)
}

public enum Direction{
    case right
    case left
}
