//
//  RefreshableScrollView.swift
//  
//
//  Created by user on 17.04.2021.
//

import Foundation
import SwiftUI


public struct RefreshableScrollView<Content: View>: View {
    
    private var threshold: CGFloat = 80
    private let refreshAction: () -> Void
    @Binding private var isRefreshing: Bool
    private let content: Content
    private var vibration: Vibration? = nil
    private var tint: Color = .accentColor
    private let coordinateSpace: String = "RefreshableScrollView"
    
    @State private var readyToRefresh: Bool = true
    @State private var rotation: Angle = .degrees(0)
    @State private var contentOffset: CGFloat = 0
    
    public init(executeOnRefresh: @escaping () -> Void, isRefreshing: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.refreshAction = executeOnRefresh
        self._isRefreshing = isRefreshing
        self.content = content()
    }
    
    public var body: some View {
        ZStack (alignment: .top){
            RefreshActivityIndicator(indicatorDiameter: threshold * 0.25, isRefreshing: isRefreshing, rotationAngle: rotation, tint: tint)
            ScrollView {
                ZStack(alignment: .top) {
                    content
                        .movingScrollViewElement(coordinateSpace: coordinateSpace)
                        .offset(y: contentOffset)
                }
            }
        }
        .fixedScrollViewElement(coordinateSpace: coordinateSpace)
        .coordinateSpace(name: coordinateSpace)
        .onPreferenceChange(FramePreferenceKey.self) { values in
            calculateScrollPosition(values: values)
        }
        .onChange(of: isRefreshing){ state in
            withAnimation(.linear(duration: 0.15)){
                contentOffset = state ? threshold/2 : 0
            }
        }
    }
    
    private func calculateScrollPosition(values: [FramePreferenceData]) {
        DispatchQueue.main.async{
            let movingBounds = values.first {$0.type == .moving}?.rect.minY ?? .zero
            let fixedBounds = values.first {$0.type == .fixed}?.rect.minY ?? .zero
            let scrollOffset = movingBounds - fixedBounds
            rotation = activityIndicatorlRotation(scrollOffset)
            if scrollOffset < threshold/2 {
                readyToRefresh = true
            }
            if readyToRefresh && scrollOffset > threshold {
                refresh()
            }
        }
    }
    
    private func refresh() {
        if let vibration = vibration{
            vibration.vibrate()
        }
        readyToRefresh = false
        isRefreshing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            refreshAction()
        }
    }
    
    private func activityIndicatorlRotation(_ scrollOffset: CGFloat) -> Angle {
        let t = Double(threshold)
        let o = Double(scrollOffset)
        return .degrees(o/t * 360)
    }
    
}

public extension RefreshableScrollView{
    
    init(executeOnRefresh: @escaping () -> Void, isRefreshing: Binding<Bool>, threshold: CGFloat = 80, inidicatorTint: Color, vibration: Vibration, @ViewBuilder content: () -> Content) {
        self.refreshAction = executeOnRefresh
        self._isRefreshing = isRefreshing
        self.threshold = threshold
        self.tint = inidicatorTint
        self.vibration = vibration
        self.content = content()
    }
    
}


