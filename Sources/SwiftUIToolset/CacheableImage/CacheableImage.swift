//
//  CacheableImage.swift
//
//
//  Created by user on 14.04.2021.
//

import SwiftUI

public struct CacheableImage: View {
    @ObservedObject public var model: CacheableImageModel

    public var placeholder: Placeholder = .`default`
    public var clipShape: ShapeType = .circle
    public var fillable: Bool = true

    public var imageWidth: CGFloat?
    public var imageHeight: CGFloat?

    public var placeholderWidth: CGFloat = 22
    public var placeholderColor: Color = Color.gray.opacity(0.2)
    public var backgroundColor: Color = Color.gray.opacity(0.1)

    @ViewBuilder
    public var body: some View {
        Group{
            if let image = model.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: fillable ? .fill : .fit)
            } else {
                placeholder.image
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(placeholderColor)
                    .frame(width: placeholderWidth)
            }
        }
        .frame(width: imageWidth, height: imageHeight)
        .frame(maxWidth: imageWidth != nil ? imageWidth : .infinity, maxHeight: imageHeight != nil ? imageHeight : .infinity)
        .background(backgroundColor)
        .shapped(by: clipShape)
    }
}


public extension CacheableImage{

    init(image: String?, placeholder: Placeholder = .`default`, clipShape: ShapeType, width: CGFloat?, height: CGFloat?, placeholderWidth: CGFloat = 22, placeholderColor: Color = Color.gray.opacity(0.2), backgroundColor: Color = Color.gray.opacity(0.1)){
        self.model = CacheableImageModel(url: image)
        self.placeholder = placeholder
        self.clipShape = clipShape
        self.imageWidth = width
        self.imageHeight = height
        self.placeholderWidth = placeholderWidth
        self.placeholderColor = placeholderColor
        self.backgroundColor = backgroundColor
    }

    init(circleImage: String?, placeholder: Placeholder = .`default`, width: CGFloat, placeholderColor: Color = Color.gray.opacity(0.2), backgroundColor: Color = Color.gray.opacity(0.1)){
        self.model = CacheableImageModel(url: circleImage)
        self.placeholder = placeholder
        self.clipShape = .circle
        self.imageWidth = width
        self.imageHeight = width
        self.placeholderWidth = min(22, width/2)
        self.placeholderColor = placeholderColor
        self.backgroundColor = backgroundColor
    }

    init(squareImage: String?, placeholder: Placeholder = .`default`, width: CGFloat, placeholderColor: Color = Color.gray.opacity(0.2), backgroundColor: Color = Color.gray.opacity(0.1)){
        self.model = CacheableImageModel(url: squareImage)
        self.placeholder = placeholder
        self.clipShape = .rectangle
        self.imageWidth = width
        self.imageHeight = width
        self.placeholderWidth = min(22, width/2)
        self.placeholderColor = placeholderColor
        self.backgroundColor = backgroundColor
    }

    init(selfAdjustableImage: String?, placeholder: Placeholder = .`default`, clipShape: ShapeType = .roundedRectangle(radius: 10), placeholderWidth: CGFloat = 22, placeholderColor: Color = Color.gray.opacity(0.2), backgroundColor: Color = Color.gray.opacity(0.1)){
        self.model = CacheableImageModel(url: selfAdjustableImage)
        self.clipShape = clipShape
        self.fillable = false
        self.placeholderWidth = placeholderWidth
        self.placeholderColor = placeholderColor
        self.backgroundColor = backgroundColor
    }

}

public enum Placeholder {
    case `default`
    case custom(image: String)
    
    public var image: Image {
        switch self {
        case .`default`: return Image("image.empty")
        case .custom(let image): return Image(image)
        }
    }
}
