//
//  RouteScreen.swift
//  WoCurrate
//
//  Created by Иван Галкин on 12.01.2025.
//

struct RouteScreen: Identifiable, Hashable {
    enum Screen: String, Hashable {
        case list, detail
    }
    
    init(_ type: Screen, _ arguments: (any RouteArgumentsProtocol)?) {
        self.id = type.rawValue
        self.type = type
        self.arguments = arguments
    }
    
    let id: String
    let type: Screen
    let arguments: (any RouteArgumentsProtocol)?
    
    static func == (lhs: RouteScreen, rhs: RouteScreen) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
