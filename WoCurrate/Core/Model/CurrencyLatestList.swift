//
//  CurrencyLatestList.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

struct CurrencyLatestList: Codable {
    let data: [String : Double]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
