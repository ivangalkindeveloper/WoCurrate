//
//  SupportedCurrencyCard.swift
//  WoCurrate
//
//  Created by Иван Галкин on 02.01.2025.
//

import SwiftUI

struct SupportedCurrencyCard: View {
    let currency: Currency
    
    var body: some View {
        HStack(alignment: .top) {
            if let symbol = currency.symbol {
                Text(symbol)
                    .padding(.trailing, 16)
            }
            HStack(alignment: .center) {
                if let name = currency.name {
                    Text(name)
                }
                if let type = currency.type {
                    Text(type)
                }
            }
            Spacer()
            if let code = currency.code{
                Text(code)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.all, 8)
    }
}
