//
//  RefreshTokenRequest.swift
//  WoCurrate
//
//  Created by Иван Галкин on 05.01.2025.
//

import Foundation

struct RefreshTokenRequest: Codable {
    let refreshToken: String?
}

fileprivate extension RefreshTokenRequest {
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
