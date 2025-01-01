//
//  ViewModel.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

protocol ViewModel: ObservableObject {}

extension ViewModel {
//    func handle(
//        _ execute: @escaping () async throws -> Void,
//        onError: @escaping () -> Void
//    ) async -> Void {
//        Task {
//            do {
//                try await execute();
//            } catch {
//                onError()
//            }
//        }
//    }
    
    func update(_ completion: @escaping () -> Void) -> Void {
        DispatchQueue.main.async {
            completion()
        }
    }
}
