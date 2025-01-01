//
//  SupportedListViewModel.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation

class SupportedListViewModel: ViewModel {
    private let service: CurrencyService = CurrencyService()
    
    @Published var supportedList: CurrencySupportedList?
    
    init() {
        self.fetchSupportedCurrencies()
    }
    
    func fetchSupportedCurrencies() {
        Task() {
            let supportedList: CurrencySupportedList? = try? await service.getSupported()
            update { [weak self] in
                self?.supportedList = supportedList
            }
        }
    }
}
