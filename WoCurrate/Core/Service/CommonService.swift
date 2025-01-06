//
//  CommonService.swift
//  WoCurrate
//
//  Created by Иван Галкин on 05.01.2025.
//

import Foundation

protocol CommonServiceProtocol {
    func refreshTokens() async throws -> Void
}

class CommonService: Service, CommonServiceProtocol {
    private enum Endpoint: String {
        case refresh = "/refresh"
    }

    func refreshTokens() async throws -> Void {
        let refreshToken: String? = UserDefaults.standard.string(
            forKey: "refresh_token")
        guard let refreshToken = refreshToken else {
            return
        }
        
        let model: TokenPair = try await self.request(
            endpoint: Endpoint.refresh.rawValue,
            body: RefreshTokenRequest(
                refreshToken: refreshToken)
        )
        
        UserDefaults.standard.set(model.accessToken,
            forKey: "access_token")
        UserDefaults.standard.set(model.refreshToken,
            forKey: "refresh_token")
    }
}
