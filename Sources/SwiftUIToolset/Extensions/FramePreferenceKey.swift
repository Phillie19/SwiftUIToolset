//
//  File.swift
//  
//
//  Created by user on 17.04.2023.
//

import Foundation
import SwiftUI

public struct FramePreferenceKey: PreferenceKey{
    public typealias Value = [FramePreferenceData]
    
    public static var defaultValue: Value = []

    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

public struct FramePreferenceData: Equatable{
    public let type: ScrollViewFrameType
    public let rect: CGRect
    
    public enum ScrollViewFrameType{
        case sticky, moving, fixed
    }
}
