//
//  RouteSheet.swift
//  WoCurrate
//
//  Created by Иван Галкин on 12.01.2025.
//

struct RouteSheet: Identifiable, Hashable {
    enum Sheet: String, Hashable {
        case some
    }
    
    init(type: Sheet, arguments: (any RouteArgumentsProtocol)?) {
        self.id = type.rawValue
        self.type = type
        self.arguments = arguments
    }
    
    let id: String
    let type: Sheet
    let arguments: (any RouteArgumentsProtocol)?
    
    static func == (lhs: RouteSheet, rhs: RouteSheet) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
