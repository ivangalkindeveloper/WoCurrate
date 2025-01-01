//
//  ServiceError.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

enum ServiceError: Error {
    case invalidData
    case invalodStatusCode
    case jsonParsing
    case requestError(description: String)
    case common(description: String)
}
