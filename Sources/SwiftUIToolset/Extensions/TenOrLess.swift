//
//  TenOrLess.swift
//  
//
//  Created by Philipp Pereverzev on 13.04.2023.
//

import SwiftUI

@propertyWrapper
public struct TenOrLess {
    private var number: CGFloat = 0
    public var wrappedValue: CGFloat {
        get { return number }
        set { number = min(max(newValue, 0), 10) }
    }
    
    public init(){
        number = 10
    }
    
    public init(wrappedValue: CGFloat) {
        number = min(max(wrappedValue, 0), 10)
    }
}
