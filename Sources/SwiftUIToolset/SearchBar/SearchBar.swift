//
//  SearchBar.swift
//  
//
//  Created by Philipp Pereverzev on 13.04.2023.
//

import SwiftUI

public struct SearchBar: View{
    
    private var search: Binding<String>
    private var placeholder: String = "Search"
    
    private var padding: CGFloat = 8
    @TenOrLess private var cornerRadius: CGFloat = 10
    
    private var textFont: Font = Font.system(size: 15)
    private var textForegroundColor: Color = Color.black
    
    private var backgroundColor: Color = Color.white
    private var elementForegroundColor: Color = Color.gray.opacity(0.3)
    private var elementSize: CGFloat = 16
    private var showsBorder: Bool = false
    
    @State private var isEditing = false
    
    public var body: some View{
        searchBar
    }
    
    private var searchBar: some View{
        HStack(spacing: 8){
            HStack(spacing: 8){
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(elementForegroundColor)
                    .frame(width: elementSize, height: elementSize)
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
                            .frame(width: elementSize, height: elementSize)
                    })
                    .padding(.trailing, padding)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor, strokeBorder: showsBorder ? elementForegroundColor : Color.clear, lineWidth: 1)
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
    
    init(search: Binding<String>, placeholder: String = "Search", font: Font, foregroundColor: Color){
        self.search = search
        self.placeholder = placeholder
        self.textFont = font
        self.textForegroundColor = foregroundColor
    }
    
    init(search: Binding<String>, placeholder: String = "Search", font: Font, foregroundColor: Color, backgroundColor: Color, UIElementsColor: Color, showsBorder: Bool = false){
        self.search = search
        self.placeholder = placeholder
        self.textFont = font
        self.textForegroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.elementForegroundColor = UIElementsColor
        self.showsBorder = showsBorder
    }
    
    init(search: Binding<String>, placeholder: String = "Search", font: UIFont, foregroundColor: Color){
        self.search = search
        self.placeholder = placeholder
        self.textFont = Font(font)
        self.textForegroundColor = foregroundColor
        self.elementSize = font.pointSize
    }
    
    init(search: Binding<String>, placeholder: String = "Search", font: UIFont, foregroundColor: Color, backgroundColor: Color, UIElementsColor: Color, showsBorder: Bool = false){
        self.search = search
        self.placeholder = placeholder
        self.textFont = Font(font)
        self.textForegroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.elementForegroundColor = UIElementsColor
        self.elementSize = font.pointSize
        self.showsBorder = showsBorder
    }
    
}

public extension SearchBar{
    
    mutating func font(_ font: Font){
        self.textFont = font
    }
    
    mutating func foregroundColor(_ color: Color){
        self.textForegroundColor = color
    }
    
    mutating func showsBorder(_ state: Bool){
        self.showsBorder = state
    }
    
    mutating func UIElementsSize(_ size: CGFloat){
        self.elementSize = size
    }
    
}


