//
//  CurrencyHistoricalList.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

struct CurrencyHistoricalList: Codable {
    let data: [Date : CurrencyLatestList]?
}

private extension CurrencyHistoricalList {
    enum CodingKeys: String, CodingKey {
        case data
    }
}
