//
//  ContentInputField + Types.swift
//  
//
//  Created by Philipp Pereverzev on 13.04.2023.
//

import SwiftUI

enum InputFieldType{
    case login
    case secured
    case alphabetic
    case numeric
    case name(type: NameType)
    case email
    case address(type: AddressType)
    case postalCode
}

extension InputFieldType: Equatable{}

enum NameType{
    case first
    case middle
    case last
}

extension NameType{
    var contentType: UITextContentType{
        switch self{
        case .first: return .givenName
        case .middle: return .middleName
        case .last: return .familyName
        }
    }
}

enum AddressType{
    case country
    case region
    case city
    case street
}

extension AddressType{
    var contentType: UITextContentType{
        switch self{
        case .country: return .countryName
        case .region: return .addressState
        case .city: return .addressCity
        case .street: return .fullStreetAddress
        }
    }
}
