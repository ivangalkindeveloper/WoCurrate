//
//  CurrencyListScreen.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import SwiftUI

struct CurrencyListScreen: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    @StateObject private var viewModel = CurrencyListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack {
                        ScrollView {
                            ForEach(
                                viewModel.supportedList,
                                id: \.self
                            ) { currency in
                                SupportedCurrencyCard(
                                    currency: currency
                                ) {
                                    coordinator.push(
                                        route: RouteScreen(
                                            .detail,
                                            CurrencyDetailArguments(
                                                currency: currency
                                            )
                                        ))
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Currencies")
            .safeAreaPadding()
            .background(Color.white)
        }
        .onAppear {
            self.viewModel.fetchSupportedCurrencies()
        }
    }
}

#Preview {
    CurrencyListScreen()
}
