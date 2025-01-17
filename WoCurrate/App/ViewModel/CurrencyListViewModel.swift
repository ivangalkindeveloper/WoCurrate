//
//  SupportedListViewModel.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import SwiftUI

@MainActor
final class CurrencyListViewModel: ViewModelProtocol {
    private let service: CurrencyService = CurrencyService()
    
    @Published var isLoading: Bool = true
    @Published var supportedList: [Currency] = []
    
    func fetchSupportedCurrencies() {
        update { [weak self] in
            self?.isLoading = true
        }
        
        handle(
            execute: {
                Task {
                    let fetchList: CurrencySupportedList = try await self.service.getSupported()
                    self.update { [weak self] in
                        self?.supportedList = fetchList.data?.map { $0.value } ?? []
                        self?.isLoading = false
                    }
                }
            },
            onError: {}
        )
    }
}
