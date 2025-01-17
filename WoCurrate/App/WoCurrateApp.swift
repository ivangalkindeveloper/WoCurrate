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

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
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


