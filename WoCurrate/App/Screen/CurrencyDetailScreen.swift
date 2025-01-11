//
//  DetailScreen.swift
//  WoCurrate
//
//  Created by Иван Галкин on 02.01.2025.
//

import SwiftUI

struct CurrencyDetailArguments: RouteArgumentsProtocol {
    let currency: Currency
}

struct CurrencyDetailScreen: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    @StateObject private var viewModel = CurrencyDetailViewModel()
    
    let arguments: CurrencyDetailArguments
    
    var body: some View {
        Text(arguments.currency.name ?? "")
    }
}

//#Preview {
//    DetailScreenView()
//}
