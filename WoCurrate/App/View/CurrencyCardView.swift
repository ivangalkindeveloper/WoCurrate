//
//  CurrencyCardView.swift
//  WoCurrate
//
//  Created by Иван Галкин on 02.01.2025.
//

import SwiftUI

struct CurrencyCardView: View {
    let currency: Currency
    let onTap: () -> Void
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture(perform: onTap)
    }
}
