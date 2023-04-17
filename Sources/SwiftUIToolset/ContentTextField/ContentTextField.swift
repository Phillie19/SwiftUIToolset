//
//  ContentTextField.swift
//  
//
//  Created by user on 13.04.2021.
//

import SwiftUI

public struct ContentTextField: View{
    
    private var type: ContentType
    private var text: Binding<String>
    private let textFieldPlaceholder: String
    private var validationError: String
    
    private var padding: CGFloat = 8
    @TenOrLess private var cornerRadius: CGFloat = 10
    
    private var textFont: Font = Font.system(size: 15)
    private var textForegroundColor: Color = Color.black
    private var textFontSize: CGFloat = 15
    
    private var errorFont: Font = Font.system(size: 10)
    private var errorForegroundColor: Color = Color.red
    
    private var backgroundColor: Color = Color.gray.opacity(0.1)
    private var eyeForegroundColor: Color {
        textForegroundColor.opacity(0.2)
    }
    
    @State private var isSecured: Bool = true
    
    public var body: some View{
        HStack(spacing:0){
            VStack(alignment: .leading, spacing:0){
                textField
                error
            }
            .padding(.horizontal, padding)
            Spacer()
            if type == .secured{
                eye
                    .padding(.trailing, padding)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, padding)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .animation(.easeIn(duration: 0.1), value: validationError)
    }
    
    @ViewBuilder
    var textField: some View{
        switch type{
        case .login:
            TextField(textFieldPlaceholder, text: text)
                .font(textFont)
                .foregroundColor(textForegroundColor)
                .textContentType(.username)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        case .secured:
            if isSecured {
                SecureField("Password", text: text)
                    .font(textFont)
                    .foregroundColor(textForegroundColor)
                    .textContentType(.password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField("Password", text: text)
                    .font(textFont)
                    .foregroundColor(textForegroundColor)
                    .textContentType(.password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        case .name(let type):
            TextField(textFieldPlaceholder, text: text)
                .font(textFont)
                .foregroundColor(textForegroundColor)
                .textContentType(type.contentType)
                .disableAutocorrection(true)
                .autocapitalization(.words)
        case .alphabetic:
            TextField(textFieldPlaceholder, text: text)
                .font(textFont)
                .foregroundColor(textForegroundColor)
                .disableAutocorrection(true)
        case .numeric:
            TextField(textFieldPlaceholder, text: text)
                .font(textFont)
                .foregroundColor(textForegroundColor)
                .keyboardType(.phonePad)
        case .email:
            TextField(textFieldPlaceholder, text: text)
                .font(textFont)
                .foregroundColor(textForegroundColor)
                .keyboardType(.emailAddress)
        case .address(let type):
            TextField(textFieldPlaceholder, text: text)
                .font(textFont)
                .foregroundColor(textForegroundColor)
                .textContentType(type.contentType)
                .disableAutocorrection(true)
                .autocapitalization(.words)
        case .postalCode:
            TextField(textFieldPlaceholder, text: text)
                .font(textFont)
                .foregroundColor(textForegroundColor)
                .textContentType(.postalCode)
                .disableAutocorrection(true)
                .autocapitalization(.allCharacters)
        }
    }
    
    @ViewBuilder
    var error: some View{
        if !validationError.isEmpty{
            Text(validationError)
                .font(errorFont)
                .foregroundColor(errorForegroundColor)
        }
    }
    
    @ViewBuilder
    var eye: some View{
        Image(isSecured ? "show" : "hide")
            .resizable()
            .scaledToFit()
            .foregroundColor(eyeForegroundColor)
            .frame(width: textFontSize, height: textFontSize + padding)
            .onTapGesture {
                isSecured.toggle()
            }
    }
    
}


public extension ContentTextField{
    
    init(text: Binding<String>, placeholder: String, validationError: String){
        self.type = .alphabetic
        self.text = text
        self.textFieldPlaceholder = placeholder
        self.validationError = validationError
    }
    
    init(type: ContentType, text: Binding<String>, placeholder: String, validationError: String){
        self.type = type
        self.text = text
        self.textFieldPlaceholder = placeholder
        self.validationError = validationError
    }
    
    
    init(type: ContentType, text: Binding<String>, placeholder: String, validationError: String, font: Font, foregroundColor: Color, errorFont: Font, errorForegroundColor: Color){
        self.type = type
        self.text = text
        self.textFieldPlaceholder = placeholder
        self.validationError = validationError
        self.textFont = font
        self.textForegroundColor = foregroundColor
        self.errorFont = errorFont
        self.errorForegroundColor = errorForegroundColor
    }
    
    init(securedText: Binding<String>, placeholder: String, validationError: String, font: Font, pointSize: CGFloat, foregroundColor: Color, errorFont: Font, errorForegroundColor: Color){
        self.type = .secured
        self.text = securedText
        self.textFieldPlaceholder = placeholder
        self.validationError = validationError
        self.textFont = font
        self.textFontSize = pointSize
        self.textForegroundColor = foregroundColor
        self.errorFont = errorFont
        self.errorForegroundColor = errorForegroundColor
    }
    
    init(type: ContentType, text: Binding<String>, placeholder: String, validationError: String, font: UIFont, foregroundColor: Color,  errorFont: UIFont, errorForegroundColor: Color){
        self.type = type
        self.text = text
        self.textFieldPlaceholder = placeholder
        self.validationError = validationError
        self.textFont = Font(font)
        self.textFontSize = font.pointSize
        self.textForegroundColor = foregroundColor
        self.errorFont = Font(errorFont)
        self.errorForegroundColor = errorForegroundColor
    }
}

extension ContentTextField{
    
    mutating func font(_ font: Font){
        self.textFont = font
    }
    
    mutating func foregroundColor(_ color: Color){
        self.textForegroundColor = color
    }
    
}
