//
//  MultilineTextField.swift
//
//
//  Created by Philipp Pereverzev on 13.04.2023.
//

import SwiftUI

public struct MultilineTextField: View{

    @Binding var text: String
    let textPlaceholder: String
    var lineLimit: Int? = nil
    var expanded: Bool = false
    
    /// Padding and corner radius values are set to paticular values to seamlessly show transition from "placeholder" to your input text. You can also set corner radius from 0 to 10.
    private var padding: CGFloat = 8
    @TenOrLess var cornerRadius: CGFloat = 10
    
    var textCustomFontName: String = ""
    var textFontSize: CGFloat = 15
    var textFontWeight: Font.Weight = .regular
    var textFontDesign: Font.Design = .default
    var textForegroundColor: Color = Color.black
    var textPlaceholderOpacity: Double = 0.5
    var backgroundColor: Color = Color.gray.opacity(0.1)
    
    @State var textEditorHeight: CGFloat = 0

    
    private var textFont: Font{
        return textCustomFontName.isEmpty ? Font.system(size: textFontSize, weight: textFontWeight, design: textFontDesign) : Font.custom(textCustomFontName, size: textFontSize)
    }
    
    private var containerMinHeight: CGFloat{
        guard let limit = lineLimit, expanded == true else { return 0}
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
    init(text: Binding<String>, placeholder: String, visibleLines: Int?){
        _text = text
        self.textPlaceholder = placeholder
        self.lineLimit = visibleLines
        self.expanded = false
    }
    
    ///Creates an input text field with a placeholder. Container height initialy set to fit maximum visible lines.
    init(textInExpandedContainer: Binding<String>, placeholder: String, visibleLines: Int){
        _text = textInExpandedContainer
        self.textPlaceholder = placeholder
        self.lineLimit = visibleLines
        self.expanded = true
    }
    
    ///Same as first init(), but with custom font setup
    init(text: Binding<String>, placeholder: String, visibleLines: Int?, customFont: String, customFontSize: CGFloat, textColor: Color){
        _text = text
        self.textPlaceholder = placeholder
        self.lineLimit = visibleLines
        self.expanded = false
        self.textCustomFontName = customFont
        self.textForegroundColor = textColor
        self.textFontSize = customFontSize
    }
    
}

