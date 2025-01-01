//
//  CurrencySupportedList.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

struct CurrencySupportedList: Codable {
    let data: [String : Currency]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
