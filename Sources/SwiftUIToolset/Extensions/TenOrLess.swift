//
//  TenOrLess.swift
//  
//
//  Created by Philipp Pereverzev on 13.04.2023.
//

import SwiftUI

@propertyWrapper
struct TenOrLess {
    private var number: CGFloat = 0
    var wrappedValue: CGFloat {
        get { return number }
        set { number = min(max(newValue, 0), 10) }
    }
    
    init(){
        number = 10
    }
    
    init(wrappedValue: CGFloat) {
        number = min(max(wrappedValue, 0), 10)
    }
}