//
//  Service.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

protocol ServiceProtocol {
    var session: URLSession { get }
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }
}

class Service: ServiceProtocol {
    let session: URLSession = URLSession.shared
    let decoder: JSONDecoder = JSONDecoder()
    let encoder: JSONEncoder = JSONEncoder()
    
    private func buildRequest(
        endpoint: String,
        method: HttpMethod?,
        queries: [String: String]?,
        additionalHeaders: [String: String]? = nil,
        body: Encodable? = nil
    ) throws -> URLRequest {
        let baseURL = "https://api.freecurrencyapi.com/v1"
        let apiKey = "fca_live_SIO8FEIzd2vdf2gGN5Hjn8brJPAp97MQOc7tWQSJ"

        guard var urlComponent = URLComponents(string: "\(baseURL)\(endpoint)") else {
            throw ServiceError.invalidURL
        }

        // MARK: Queries

        urlComponent.queryItems = [
            URLQueryItem(
                name: "apikey",
                value: apiKey),
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
        method: HttpMethod?
    ) {
        request.httpMethod = method?.rawValue
    }
    
    // MARK: Headers

    private func addHeaders(
        request: inout URLRequest,
        headers: [String: String]?
    ) {
        request.setValue(
            "application/json",
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
    ) {
        guard let body = body else {
            return
        }
        request.httpBody = try? self.encoder.encode(body)
    }

    func request<T: Codable>(
        endpoint: String,
        method: HttpMethod? = nil,
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

        let (data, response) = try await self.session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw ServiceError.invalidResponse
        }
        
        if response.statusCode == 403 {
            do {
                let commonService = CommonService()
                try await commonService.refreshTokens()
            } catch {
                throw ServiceError.unauthorized
            }
            
            return try await self.request(
                endpoint: endpoint,
                method: method,
                queries: queries,
                additionalHeaders: additionalHeaders,
                body: body)
        }
        
        switch response.statusCode {
            case 200 ..< 400: break
            case 400 ..< 500: throw ServiceError.client
            case 500 ..< 600: throw ServiceError.server
            default: throw ServiceError.invalodStatusCode
        }
        
        guard let model: T = try? self.decoder.decode(T.self, from: data) else {
            throw ServiceError.jsonParsing
        }

        return model
    }
}
