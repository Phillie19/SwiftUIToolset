//
//  SearchBar.swift
//  
//
//  Created by Philipp Pereverzev on 13.04.2023.
//

import SwiftUI

struct SearchBar: View{
    
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
    var elementForegroundColor: Color {
        textForegroundColor.opacity(0.2)
    }
    
    @State private var isEditing = false
    
    private var textFont: Font{
        return textCustomFontName.isEmpty ? Font.system(size: textFontSize, weight: textFontWeight, design: textFontDesign) : Font.custom(textCustomFontName, size: textFontSize)
    }
    
    var body: some View{
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
                RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor, strokeBorder: elementForegroundColor, lineWidth: 1)
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

extension SearchBar{

    init(search: Binding<String>, placeholder: String){
        self.search = search
        self.placeholder = placeholder
    }
    
}

