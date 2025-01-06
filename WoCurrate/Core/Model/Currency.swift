//
//  Currency.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

struct Currency: Codable, Hashable {
    let symbol: String?
    let name: String?
    let symbolNative: String?
    let decimalDigits: Int?
    let rounding: Int?
    let code: String?
    let namePlural: String?
    let type: String?
}

fileprivate extension Currency {
    enum CodingKeys: String, CodingKey {
        case symbol, name, rounding, code, type
        case symbolNative = "symbol_native"
        case decimalDigits = "decimal_digits"
        case namePlural = "name_plural"
    }
}
