//
//  LoadingView.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 08/12/2025.
//

import SwiftUI

struct FullScreenLoadingView: View {
    var body: some View {
        VStack(spacing: 10) {
            ProgressView()
                .progressViewStyle(.automatic)
                .padding(.top)
            Text("Loading")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(.gray).opacity(0.8)
    }
}

#Preview {
    FullScreenLoadingView()
}
