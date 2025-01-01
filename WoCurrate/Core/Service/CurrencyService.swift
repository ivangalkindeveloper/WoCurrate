//
//  CurrencyService.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

protocol CurrencyServiceProtocol: Service {
    func getSupported() async throws -> CurrencySupportedList
}

class CurrencyService: CurrencyServiceProtocol {
    enum CurrencyEndpoint: String {
        case currencies = "/currencies"
    }
    
    func getSupported() async throws -> CurrencySupportedList {
        guard let data = try await get(endpoint: CurrencyEndpoint.currencies.rawValue) else {
            throw ServiceError.invalidData
        }
        guard let model = try? JSONDecoder().decode(CurrencySupportedList.self, from: data) else {
            throw ServiceError.jsonParsing
        }
        
        return model
    }
}
