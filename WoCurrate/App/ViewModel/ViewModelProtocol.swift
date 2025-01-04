///Users/ivangalkin/Development/My projects/swift/WoCurrate/WoCurrate/App/ViewModel/SupportedListViewModel.swift
//  ViewModel.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {}

extension ViewModelProtocol {
    func handle(
        execute: @escaping () throws -> Void,
        onError: @escaping () -> Void
    ) -> Void {
            do {
                try execute()
            } catch {
                onError()
            }
    }
    
    func update(completion: @escaping () -> Void) -> Void {
        DispatchQueue.main.async {
            completion()
        }
    }
}
