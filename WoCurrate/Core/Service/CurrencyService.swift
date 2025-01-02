//
//  CurrencyService.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

protocol CurrencyServiceProtocol: Service {
    func getSupported() async throws -> CurrencySupportedList
    
    func getLatest(base: String) async throws -> CurrencyLatestList
    
    func getHistorical(base: String) async throws -> CurrencyHistoricalList
}

class CurrencyService: CurrencyServiceProtocol {
    private enum Endpoint: String {
        case currencies = "/currencies"
        case latest = "/latest"
        case historical = "/historical"
    }

    func getSupported() async throws -> CurrencySupportedList {
        let model: CurrencySupportedList = try await request(
            endpoint: Endpoint.currencies.rawValue,
            method: HTTPMethod.GET)
        return model
    }

    func getLatest(base: String) async throws -> CurrencyLatestList {
        let model: CurrencyLatestList = try await request(
            endpoint: Endpoint.latest.rawValue,
            query: ["base": base],
            method: HTTPMethod.GET)
        return model
    }
    
    func getHistorical(base: String) async throws -> CurrencyHistoricalList {
        let today = Date()
        let lastYear = Calendar.current.date(byAdding: .year, value: -1, to: today)!
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-dd"
        
        let model: CurrencyHistoricalList = try await request(
            endpoint: Endpoint.historical.rawValue,
            query: ["base": base,
                    "date": inputFormatter.string(from: lastYear)],
            method: HTTPMethod.GET)
        return model
    }
}
