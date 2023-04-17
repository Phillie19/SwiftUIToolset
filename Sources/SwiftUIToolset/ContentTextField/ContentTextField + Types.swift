//
//  ContentInputField + Types.swift
//  
//
//  Created by user on 13.04.2021.
//

import SwiftUI

public enum ContentType{
    case login
    case secured
    case alphabetic
    case numeric
    case name(type: NameType)
    case email
    case address(type: AddressType)
    case postalCode
}

extension ContentType: Equatable{}

public enum NameType{
    case first
    case middle
    case last
}

public extension NameType{
    var contentType: UITextContentType{
        switch self{
        case .first: return .givenName
        case .middle: return .middleName
        case .last: return .familyName
        }
    }
}

public enum AddressType{
    case country
    case region
    case city
    case street
}

public extension AddressType{
    var contentType: UITextContentType{
        switch self{
        case .country: return .countryName
        case .region: return .addressState
        case .city: return .addressCity
        case .street: return .fullStreetAddress
        }
    }
}
