//
//  ViewSizeCalculator.swift
//  
//
//  Created by user on 13.04.2021.
//

import SwiftUI

public extension View{
    
    func calculateViewSize(_ callback: @escaping (CGSize) -> Void) -> some View{
        modifier(ViewSizeCalculator(callback: callback))
    }
}


struct ViewSizeCalculator: ViewModifier{

    var callback: (CGSize) -> Void
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { proxy in
                let frame = proxy.frame(in: .global).size
                Color.clear
                    .onAppear{callback(frame)}
                    .onChange(of: frame){frame in
                        callback(frame)}
            })
    }

}
