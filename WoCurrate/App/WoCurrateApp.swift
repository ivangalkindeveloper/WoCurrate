//
//  WoCurrateApp.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import SwiftUI

@main
struct WoCurrateApp: App {
    init() {
        loadRocketSimConnect()
    }
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SupportedListScreenView()
        }
    }
    
    private func loadRocketSimConnect() {
        #if DEBUG
        guard (Bundle(path: "/Applications/RocketSim.app/Contents/Frameworks/RocketSimConnectLinker.nocache.framework")?.load() == true) else {
            return print("Failed to load linker framework")
        }
        print("RocketSim Connect successfully linked")
        #endif
    }
}


