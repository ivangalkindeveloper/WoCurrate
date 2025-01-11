//
//  Coordinator.swift
//  WoCurrate
//
//  Created by Иван Галкин on 11.01.2025.
//

import Foundation
import SwiftUI

protocol CoordinatorProtocol {
    var path: NavigationPath { get }
    var sheet: RouteSheet? { get }
    var fullScreenCover: RouteFullScreenCover? { get }
    
    func push(route: RouteScreen) -> Void
    
    func push(route: RouteSheet) -> Void
    
    func push(route: RouteFullScreenCover) -> Void
    
    func pop() -> Void
    
    func popRoot() -> Void
    
    func dismissSheet() -> Void
    
    func dismissFullScreenCover() -> Void
}

final class Coordinator: CoordinatorProtocol, ObservableObject {    
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: RouteSheet?
    @Published var fullScreenCover: RouteFullScreenCover?
    
    func push(route: RouteScreen) -> Void {
        path.append(route)
    }
    
    func push(route: RouteSheet) -> Void {
        self.sheet = route
    }
    
    func push(route: RouteFullScreenCover) -> Void {
        self.fullScreenCover = route
    }
    
    func pop() -> Void {
        path.removeLast()
    }
    
    func popRoot() -> Void {
        path.removeLast(path.count)
    }
    
    func dismissSheet() -> Void  {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(route: RouteScreen) -> some View {
        switch route.type {
        case .list:
            CurrencyListScreen()
            
        case .detail:
            CurrencyDetailScreen(
                arguments: route.arguments as! CurrencyDetailArguments
            )
        }
    }
    
    @ViewBuilder
    func build(route: RouteSheet) -> some View {
        switch route.type {
        case .some:
            VStack {}
        }
    }
    
    @ViewBuilder
    func build(route: RouteFullScreenCover) -> some View {
        switch route.type {
        case .some:
            VStack {}
        }
    }
}
