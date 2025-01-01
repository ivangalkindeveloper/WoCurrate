//
//  Service.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

protocol Service {}

extension Service {
    func get(endpoint: String) async throws -> Data? {
        let baseURL: String = "https://api.freecurrencyapi.com/v1"
        let apikey: String = "fca_live_SIO8FEIzd2vdf2gGN5Hjn8brJPAp97MQOc7tWQSJ"
        
        var request: URLRequest = URLRequest(url: URL(string: "\(baseURL)\(endpoint)?apikey=\(apikey)")!)
        request.httpMethod = "GET"
        
        return await withCheckedContinuation{ continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    return continuation.resume(returning: nil)
                }
                guard let data = data else {
                    return continuation.resume(returning: nil)
                }
                
                continuation.resume(returning: data)
            }.resume()
        }
    }
}
