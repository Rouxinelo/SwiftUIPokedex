//
//  ImageButton.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 26/12/2025.
//

import SwiftUI

struct ImageButton: View {
    var imageName: String
    var text: String
    var backgroundColor: Color
    var onClick: () -> Void
    
    var body: some View {
        ZStack {
            backgroundColor
            HStack(spacing: 10) {
                Image(imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(text)
                    .foregroundStyle(.white)
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .frame(minWidth: 120)
        .frame(height: 35)
        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
        .onTapGesture {
            onClick()
        }
    }
}

#Preview {
    ImageButton(imageName: "pokeball",
                text: "Capture",
                backgroundColor: .red,
                onClick: {})
}
