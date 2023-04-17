//
//  File.swift
//  
//
//  Created by user on 17.04.2023.
//

import Foundation
import SwiftUI

protocol RefreshableScrollViewIndicator{
    
    var indicatorDiameter: CGFloat { get set}
    var isRefreshing: Bool { get set}
    var rotationAngle: Angle { get set }
    var tint: Color {get set}
    
}

public struct RefreshActivityIndicator: View, RefreshableScrollViewIndicator {

    var indicatorDiameter: CGFloat
    var isRefreshing: Bool
    var rotationAngle: Angle
    var tint: Color = .accentColor
    
    private var animation: Animation{
        Animation.linear(duration: isRefreshing ? 1 : 0).repeatForever(autoreverses: false)
    }
    
    public var body: some View {
        Circle()
            .trim(from: 0.0, to: 0.6)
            .stroke(tint, lineWidth: 4)
            .frame(width: indicatorDiameter, height: indicatorDiameter)
            .rotationEffect(Angle(degrees: isRefreshing ? 720 : rotationAngle.degrees))
            .animation(animation, value: isRefreshing)
            .padding()
    }
}
