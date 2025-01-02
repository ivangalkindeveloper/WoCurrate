//
//  Service.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET",
         POST = "POST",
         PUT = "PUT",
         DELETE = "DELETE"
}

extension URLRequest {
    mutating func applyMethod(
        method: HTTPMethod?
    ) -> Void {
        self.httpMethod = method?.rawValue
    }
    
    mutating func applyHeaders() {
        self.setValue("Application/json",
                      forHTTPHeaderField: "Content-Type")
    }
}

protocol Service {}

extension Service {
    private func prepareRequest(
        endpoint: String,
        query: Dictionary<String, String>?,
        method: HTTPMethod?,
        body: Encodable? = nil
    ) -> URLRequest {
        let baseURL: String = "https://api.freecurrencyapi.com/v1"
        let apikey: String = "fca_live_SIO8FEIzd2vdf2gGN5Hjn8brJPAp97MQOc7tWQSJ"
        
        var urlComponent = URLComponents(string: "\(baseURL)\(endpoint)")!
        urlComponent.queryItems = [
            URLQueryItem(name: "apikey", value: apikey),
        ]
        
        let items: [URLQueryItem] = (query ?? [:]).map{ URLQueryItem(name: $0.key, value: $0.value) }
        urlComponent.queryItems?.append(contentsOf: items)
        
        var request: URLRequest = URLRequest(url: urlComponent.url!)
        request.applyMethod(method: method)
        request.applyHeaders()
        switch method {
        case .POST:
            guard let body = body else {
                break
            }
            request.httpBody = try? JSONEncoder().encode(body)
        default: break
        }
        
        return request
    }
    
    func request<T: Codable>(
        endpoint: String,
        query: Dictionary<String, String>? = nil,
        method: HTTPMethod? = nil,
        body: Encodable? = nil
    ) async throws -> T {
        let request: URLRequest = prepareRequest(
            endpoint: endpoint,
            query: query,
            method: method,
            body: body)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let response = response as? HTTPURLResponse, response.statusCode > 299 {
            throw ServiceError.invalodStatusCode
        }
        guard let model: T = try? JSONDecoder().decode(T.self, from: data) else {
            throw ServiceError.jsonParsing
        }
        
        return model
    }
}





