//
//  Service.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

protocol ServiceProtocol {}

extension ServiceProtocol {
    private func buildRequest(
        endpoint: String,
        method: HTTPMethod?,
        queries: [String: String]?,
        additionalHeaders: [String: String]? = nil,
        body: Encodable? = nil
    ) throws -> URLRequest {
        let baseURL: String = "https://api.freecurrencyapi.com/v1"
        let apiKey: String = "fca_live_SIO8FEIzd2vdf2gGN5Hjn8brJPAp97MQOc7tWQSJ"

        guard var urlComponent = URLComponents(string: "\(baseURL)\(endpoint)") else {
            throw ServiceError.invalidURL
        }

        // MARK: Queries

        urlComponent.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
        ]
        for query in (queries ?? [:]).enumerated() {
            urlComponent.queryItems?.append(
                URLQueryItem(
                    name: query.element.key,
                    value: query.element.value))
        }

        guard let url = urlComponent.url else {
            throw ServiceError.invalidURL
        }
        
        return URLRequest(url: url)
    }
    
    // MARK: Method
    private func addMethod(
        request: inout URLRequest,
        method: HTTPMethod?
    ) -> Void {
        request.httpMethod = method?.rawValue
    }
    
    // MARK: Headers
    private func addHeaders(
        request: inout URLRequest,
        headers: [String: String]?
    ) -> Void {
        request.setValue("Application/json",
                         forHTTPHeaderField: "Content-Type")
        for header in (headers ?? [:]).enumerated() {
            request.setValue(
                header.element.key,
                forHTTPHeaderField: header.element.value)
        }
    }
    
    // MARK: Body
    private func addBody(
        request: inout URLRequest,
        body: Encodable?
    ) -> Void {
        if let body = body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
    }

    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethod? = nil,
        queries: [String: String]? = nil,
        additionalHeaders: [String: String]? = nil,
        body: Encodable? = nil
    ) async throws -> T {
        var request: URLRequest = try buildRequest(
            endpoint: endpoint,
            method: method,
            queries: queries,
            body: body)
        addMethod(
            request: &request,
            method: method)
        addHeaders(
            request: &request,
            headers: additionalHeaders)
        addBody(
            request: &request,
            body: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
                    case 200 ..< 400: break
                    case 400 ..< 500: throw ServiceError.client
                    case 500 ..< 600: throw ServiceError.server
                    default: throw ServiceError.invalodStatusCode
                }
        }
        guard let model: T = try? JSONDecoder().decode(T.self, from: data) else {
            throw ServiceError.jsonParsing
        }

        return model
    }
}
