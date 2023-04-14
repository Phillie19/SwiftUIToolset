//
//  ContentInputField.swift
//  
//
//  Created by Philipp Pereverzev on 13.04.2023.
//

import SwiftUI

public struct ContentInputField: View{
    
    var type: InputFieldType
    var text: Binding<String>
    let textFieldPlaceholder: String
    var validationError: String
    
    private var padding: CGFloat = 8
    @TenOrLess var cornerRadius: CGFloat = 10
    
    var textCustomFontName: String = ""
    var textFontSize: CGFloat = 15
    var textFontWeight: Font.Weight = .regular
    var textFontDesign: Font.Design = .default
    var textForegroundColor: Color = Color.black
    
    var errorFontSize: CGFloat = 10
    var errorFontWeight: Font.Weight = .regular
    var errorFontDesign: Font.Design = .default
    var errorForegroundColor: Color = Color.red
    
    var backgroundColor: Color = Color.gray.opacity(0.1)
    var eyeForegroundColor: Color {
        textForegroundColor.opacity(0.2)
    }
    
    @State private var isSecured: Bool = true
    
    private var textFont: Font{
        return textCustomFontName.isEmpty ? Font.system(size: textFontSize, weight: textFontWeight, design: textFontDesign) : Font.custom(textCustomFontName, size: textFontSize)
    }
    
    private var errorFont: Font{
        return textCustomFontName.isEmpty ? Font.system(size: errorFontSize, weight: errorFontWeight, design: errorFontDesign) : Font.custom(textCustomFontName, size: errorFontSize)
    }
    
    public var body: some View{
        HStack(spacing:0){
            VStack(alignment: .leading, spacing:0){
                textField
                    .font(textFont)
                    .foregroundColor(textForegroundColor)
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


public extension ContentInputField{
    
    init(text: Binding<String>, placeholder: String, validationError: String){
        self.type = .alphabetic
        self.text = text
        self.textFieldPlaceholder = placeholder
        self.validationError = validationError
    }
    
    init(type: InputFieldType, text: Binding<String>, placeholder: String, validationError: String){
        self.type = type
        self.text = text
        self.textFieldPlaceholder = placeholder
        self.validationError = validationError
    }
    
    init(type: InputFieldType, text: Binding<String>, placeholder: String, validationError: String, customFont: String, textCustomFontSize: CGFloat, errorCustomFontSize: CGFloat){
        self.type = type
        self.text = text
        self.textFieldPlaceholder = placeholder
        self.validationError = validationError
        self.textCustomFontName = customFont
        self.textFontSize = textCustomFontSize
        self.errorFontSize = errorCustomFontSize
    }
    
}



