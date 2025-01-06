//
//  TokenPair.swift
//  WoCurrate
//
//  Created by Иван Галкин on 05.01.2025.
//

import Foundation

struct TokenPair: Codable {
    let accessToken: String?
    let refreshToken: String?
}

fileprivate extension TokenPair {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
