//
//  SupportedListViewModel.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import Foundation
import SwiftUI

@MainActor
class SupportedListViewModel: ViewModelProtocol {
    private let service: CurrencyService = CurrencyService()
    
    @State var navigationPath = NavigationPath()
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
    
    func onDetailTap(currency: Currency) {
        guard let code = currency.code else {
            return;
        }
        navigationPath.append(SupportedListViewModel.Path.detail(code: code))
    }
    
    @ViewBuilder func navigationDestination(value: Path) -> some View {
        switch value {
        case let .detail(code):
            DetailScreenView(path: $navigationPath, iso2Code: code)
        }
    }
}

extension SupportedListViewModel {
    enum Path: Hashable {
        case detail(code: String)
    }
}
