//
//  File.swift
//  
//
//  Created by user on 17.04.2021.
//

import SwiftUI


public extension View{
    
    func fixedScrollViewElement(coordinateSpace: String) -> some View{
        modifier(ScrollViewElementFrame(type: .fixed, coordinateSpace: coordinateSpace))
    }

    func movingScrollViewElement(coordinateSpace: String) -> some View{
        modifier(ScrollViewElementFrame(type: .moving, coordinateSpace: coordinateSpace))
    }
    
    func stickyScrollViewElement(coordinateSpace: String, covered: Bool) -> some View{
        modifier(ScrollViewElementFrame(type: .sticky, covered: covered, coordinateSpace: coordinateSpace))
    }
    
}


public struct ScrollViewElementFrame: ViewModifier{
    @State var frame: CGRect = .zero
    var type: FramePreferenceData.ScrollViewFrameType
    var covered: Bool = false
    var coordinateSpace: String
    
    
    public func body(content: Content) -> some View {
        content
            .zIndex(covered ? 0 : 1)
            .offset(y: type == .sticky ? -frame.minY : 0)
            .overlay(GeometryReader { proxy in
                let frame = proxy.frame(in: .named(coordinateSpace))
                Color.clear
                    .onAppear{self.frame = frame}
                    .onChange(of: frame){frame in
                        self.frame = frame}
                    .preference(key: FramePreferenceKey.self, value: [FramePreferenceData(type: type, rect: self.frame)])
            })
    }
    
}
