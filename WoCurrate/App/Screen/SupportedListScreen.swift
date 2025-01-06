//
//  SupportedListScreen.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import SwiftUI

struct SupportedListScreen: View {
    @StateObject private var viewModel = SupportedListViewModel()

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
                                NavigationLink(
                                    value: currency
                                ) {
                                    SupportedCurrencyCard(
                                        currency: currency
                                    )
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Currencies")
            .safeAreaPadding()
            .background(Color.white)
            .navigationDestination(
                for: Currency.self
            ) { currency in
                DetailScreen(currency: currency)
            }
        }
        .onAppear {
            self.viewModel.fetchSupportedCurrencies()
        }
    }
}

#Preview {
    SupportedListScreen()
}
