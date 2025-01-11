//
//  CoordinatorView.swift
//  WoCurrate
//
//  Created by Иван Галкин on 11.01.2025.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator: Coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(
            path: $coordinator.path
        ) {
            coordinator.build(
                route: RouteScreen(.list, nil)
            ).navigationDestination(
                for: RouteScreen.self
            ) { route in
                coordinator.build(route: route)
            }.sheet(
                item: $coordinator.sheet
            ) { route in
                coordinator.build(route: route)
            }.fullScreenCover(
                item: $coordinator.fullScreenCover
            ) { route in
                coordinator.build(route: route)
            }
        }.environmentObject(coordinator)
    }
}
    
