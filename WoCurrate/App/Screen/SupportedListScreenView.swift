//
//  SupportedListScreenView.swift
//  WoCurrate
//
//  Created by Иван Галкин on 31.12.2024.
//

import SwiftUI

struct SupportedListScreenView: View {
    @StateObject private var viewModel: SupportedListViewModel = .init()
    
    var body: some View {
        Group {
            if viewModel.isLoading{
                ProgressView()
            } else {
                NavigationStack(path: viewModel.$navigationPath) {
                    VStack {
                        ScrollView {
                            ForEach(viewModel.supportedList, id: \.self) { currency in
                                CurrencyCardView(currency: currency) {
                                    print("Hello!!!")
                                }
                            }
                        }
                    }
                    .safeAreaPadding()
                    .background(Color.white)
                    .navigationDestination(
                        for: SupportedListViewModel.Path.self,
                        destination: viewModel.navigationDestination)
                }
            }
        }.onAppear {
            self.viewModel.fetchSupportedCurrencies()
        }
    }
}

#Preview {
    SupportedListScreenView()
}


