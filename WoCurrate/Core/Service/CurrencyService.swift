//
//  CurrencyService.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

protocol CurrencyServiceProtocol: ServiceProtocol {
    func getSupported() async throws -> CurrencySupportedList
    
    func getLatest(base: String) async throws -> CurrencyLatestList
    
    func getHistorical(base: String) async throws -> CurrencyHistoricalList
}

class CurrencyService: CurrencyServiceProtocol {
    private enum Endpoint: String {
        case currencies = "/currencies",
             latest = "/latest",
             historical = "/historical"
    }

    func getSupported() async throws -> CurrencySupportedList {
        return try await request(
            endpoint: Endpoint.currencies.rawValue,
            method: HTTPMethod.GET)
    }

    func getLatest(base: String) async throws -> CurrencyLatestList {
        return try await request(
            endpoint: Endpoint.latest.rawValue,
            method: HTTPMethod.GET,
            queries: ["base": base])
    }
    
    func getHistorical(base: String) async throws -> CurrencyHistoricalList {
        let today = Date()
        let lastYear = Calendar.current.date(byAdding: .year, value: -1, to: today)!
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-dd"
        
        return try await request(
            endpoint: Endpoint.historical.rawValue,
            method: HTTPMethod.GET,
            queries: ["base": base,
                    "date": inputFormatter.string(from: lastYear)])
    }
}
