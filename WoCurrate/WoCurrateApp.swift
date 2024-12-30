//
//  WoCurrateApp.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import SwiftUI

@main
struct WoCurrateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
