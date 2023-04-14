//
//  MultilineTextField.swift
//
//
//  Created by Philipp Pereverzev on 13.04.2023.
//

import SwiftUI

public struct MultilineTextField: View{

    @Binding var text: String
    private let textPlaceholder: String
    private var lineLimit: Int? = nil
    private var expanded: Bool = false
    
    private var textFont: Font = Font.system(size: 15)
    private var textForegroundColor: Color = Color.black
    private var textFontSize: CGFloat = 15
    private var textPlaceholderOpacity: Double = 0.5
    private var backgroundColor: Color = Color.white
    
    ///Padding and corner radius values are set to paticular values to seamlessly show transition from "placeholder" to your input text. You can also set corner radius from 0 to 10.
    private var padding: CGFloat = 8
    @TenOrLess private var cornerRadius: CGFloat = 10
    @State private var textEditorHeight: CGFloat = 0
    
    private var containerMinHeight: CGFloat{
        guard let limit = lineLimit, expanded == true else {return 0}
        return CGFloat((limit + 1) * Int(textFontSize))
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            Text(text.isEmpty ? textPlaceholder : text)
                .font(textFont)
                .foregroundColor(text.isEmpty ? textForegroundColor.opacity(textPlaceholderOpacity) : Color.clear)
                .lineLimit(lineLimit)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, minHeight: containerMinHeight, alignment: .topLeading)
                .padding(.vertical, padding)
                .padding(.horizontal, padding + padding/2)
                .calculateViewSize{ rect in
                    textEditorHeight = rect.height
                }
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
            TextEditor(text: $text)
                .font(textFont)
                .foregroundColor(textForegroundColor)
                .frame(height: textEditorHeight)
                .padding(.horizontal, padding)
        }
        .onAppear{
            UITextView.appearance().backgroundColor = .clear
        }
    }

}

public extension MultilineTextField{
    
    ///Creates an input text field with a placeholder. Container height initially set to fit one line. It expands/collapses on change of input text number of lines. You can also set maximum number of visible lines.
    init(text: Binding<String>, placeholder: String, visibleLines: Int?, backgroundColor: Color = Color.white){
        _text = text
        self.textPlaceholder = placeholder
        self.lineLimit = visibleLines
        self.expanded = false
        self.backgroundColor = backgroundColor
    }
    
    ///Same as first init(), but with custom font setup
    init(text: Binding<String>, placeholder: String, visibleLines: Int?, font: Font, pointSize: CGFloat, foregroundColor: Color, backgroundColor: Color = Color.white){
        _text = text
        self.textPlaceholder = placeholder
        self.lineLimit = visibleLines
        self.expanded = false
        self.textFont = font
        self.textForegroundColor = foregroundColor
        self.textFontSize = pointSize
        self.backgroundColor = backgroundColor
    }
    
    init(text: Binding<String>, placeholder: String, visibleLines: Int?, font: UIFont, foregroundColor: Color, backgroundColor: Color = Color.white){
        _text = text
        self.textPlaceholder = placeholder
        self.lineLimit = visibleLines
        self.expanded = false
        self.textFont = Font(font)
        self.textForegroundColor = foregroundColor
        self.textFontSize = font.pointSize
        self.backgroundColor = backgroundColor
    }
    
    ///Creates an input text field with a placeholder. Container height initialy set to fit maximum visible lines.
    init(textInExpandedContainer: Binding<String>, placeholder: String, visibleLines: Int, backgroundColor: Color = Color.white){
        _text = textInExpandedContainer
        self.textPlaceholder = placeholder
        self.lineLimit = visibleLines
        self.expanded = true
        self.backgroundColor = backgroundColor
    }
    
    init(textInExpandedContainer: Binding<String>, placeholder: String, visibleLines: Int?, font: Font, pointSize: CGFloat, foregroundColor: Color, backgroundColor: Color = Color.white){
        _text = textInExpandedContainer
        self.textPlaceholder = placeholder
        self.lineLimit = visibleLines
        self.expanded = true
        self.textFont = font
        self.textForegroundColor = foregroundColor
        self.textFontSize = pointSize
        self.backgroundColor = backgroundColor
    }
    
    init(textInExpandedContainer: Binding<String>, placeholder: String, visibleLines: Int?, font: UIFont, foregroundColor: Color, backgroundColor: Color = Color.white){
        _text = textInExpandedContainer
        self.textPlaceholder = placeholder
        self.lineLimit = visibleLines
        self.expanded = true
        self.textFont = Font(font)
        self.textForegroundColor = foregroundColor
        self.textFontSize = font.pointSize
        self.backgroundColor = backgroundColor
    }
    
}


extension MultilineTextField{
    
    mutating func font(_ font: Font){
        self.textFont = font
    }
    
    mutating func foregroundColor(_ color: Color){
        self.textForegroundColor = color
    }
    
    mutating func backgroundColor(_ color: Color){
        self.backgroundColor = color
    }
}
