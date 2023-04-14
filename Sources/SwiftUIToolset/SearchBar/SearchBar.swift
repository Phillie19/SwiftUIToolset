//
//  SearchBar.swift
//  
//
//  Created by Philipp Pereverzev on 13.04.2023.
//

import SwiftUI

public struct SearchBar: View{
    
    var search: Binding<String>
    var placeholder: String = "Search"
    
    var padding: CGFloat = 8
    @TenOrLess var cornerRadius: CGFloat = 10
    
    var textCustomFontName: String = ""
    var textFontSize: CGFloat = 15
    var textFontWeight: Font.Weight = .regular
    var textFontDesign: Font.Design = .default
    var textForegroundColor: Color = Color.black
    
    var backgroundColor: Color = Color.gray.opacity(0.1)
    var elementForegroundColor: Color = Color.gray.opacity(0.2)
    var showBorder: Bool = false
    
    @State private var isEditing = false
    
    private var textFont: Font{
        return textCustomFontName.isEmpty ? Font.system(size: textFontSize, weight: textFontWeight, design: textFontDesign) : Font.custom(textCustomFontName, size: textFontSize)
    }
    
    public var body: some View{
        HStack(spacing: 8){
            HStack(spacing: 8){
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(elementForegroundColor)
                    .frame(width: textFontSize, height: textFontSize)
                    .padding(.leading, padding)
                TextField(placeholder, text: search)
                    .font(textFont)
                    .foregroundColor(textForegroundColor)
                    .disableAutocorrection(true)
                    .padding(.vertical, padding)
                if !search.wrappedValue.isEmpty {
                    Button(action: {
                        search.wrappedValue = ""
                    }, label: {
                        Image("xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(elementForegroundColor)
                            .frame(width: 16, height: 16)
                    })
                    .padding(.trailing, padding)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor, strokeBorder: showBorder ? elementForegroundColor : Color.clear, lineWidth: 1)
            )
            .onTapGesture { withAnimation {self.isEditing = true}}
            if isEditing {
                Button(action: {
                    withAnimation {isEditing = false}
                    search.wrappedValue = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .font(textFont)
                        .foregroundColor(elementForegroundColor)
                })
                .transition(.move(edge: .trailing))
            }
        }
    }
}

public extension SearchBar{

    init(search: Binding<String>, placeholder: String = "Search"){
        self.search = search
        self.placeholder = placeholder
    }
    
    init(search: Binding<String>, placeholder: String = "Search", textColor: Color, UIElementsColor: Color, backgroundColor: Color, showBorder: Bool = false){
        self.search = search
        self.placeholder = placeholder
        self.textForegroundColor = textColor
        self.backgroundColor = backgroundColor
        self.elementForegroundColor = UIElementsColor
        self.showBorder = showBorder
    }
    
    init(search: Binding<String>, placeholder: String = "Search", customFontName: String, customFontSize: CGFloat, textColor: Color, UIElementsColor: Color, backgroundColor: Color, showBorder: Bool = false){
        self.search = search
        self.placeholder = placeholder
        self.textCustomFontName = customFontName
        self.textFontSize = customFontSize
        self.textForegroundColor = textColor
        self.backgroundColor = backgroundColor
        self.elementForegroundColor = UIElementsColor
        self.showBorder = showBorder
    }
    
}

