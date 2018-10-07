//
//  Record.swift
//  PhoneVerification
//
//  Created by Menesidis on 04/10/2018.
//  Copyright © 2018 Menesidis. All rights reserved.
//

import Foundation

struct Record: Decodable {
    let id: String
    let phoneNumber: String
    let isValid: Bool
    let countryCallingCode: String
    let lineType: String
    let carrier: String
    
    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try map.decode(String.self, forKey: .id)
        phoneNumber = try map.decode(String.self, forKey: .phonenumber)
        isValid = try map.decode(Bool.self, forKey: .isValid)
        countryCallingCode = try map.decode(String.self, forKey: .countryCallingCode)
        lineType = try map.decode(String.self, forKey: .lineType)
        carrier = try map.decode(String.self, forKey: .carrier)
    }
    

    private enum CodingKeys : String, CodingKey {
        case id
        case phonenumber = "phone_number"
        case isValid = "is_valid"
        case countryCallingCode = "country_calling_code"
        case lineType = "line_type"
        case carrier
    }
}
