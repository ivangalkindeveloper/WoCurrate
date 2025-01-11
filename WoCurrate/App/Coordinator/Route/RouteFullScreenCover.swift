//
//  FullScreenCoverRoute.swift
//  WoCurrate
//
//  Created by Иван Галкин on 12.01.2025.
//

struct RouteFullScreenCover: Identifiable, Hashable {
    enum FullScreenCover: String, Hashable {
        case some
    }
    
    init(type: FullScreenCover, arguments: (any RouteArgumentsProtocol)?) {
        self.id = type.rawValue
        self.type = type
        self.arguments = arguments
    }
    
    let id: String
    let type: FullScreenCover
    let arguments: (any RouteArgumentsProtocol)?
    
    static func == (lhs: RouteFullScreenCover, rhs: RouteFullScreenCover) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
