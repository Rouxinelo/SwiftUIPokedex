//
//  TableLoadingView.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 08/12/2025.
//

import SwiftUI

struct TableLoadingView: View {
    var body: some View {
        VStack(spacing: 10) {
            ProgressView()
                .progressViewStyle(.automatic)
            Text("Loading")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    TableLoadingView()
}
