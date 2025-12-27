//
//  StatBar.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 26/12/2025.
//

import SwiftUI

struct StatBar: View {
    var statName: String
    var statColor: Color
    var statValue: CGFloat
    var statMax: CGFloat
    
    var body: some View {
        HStack {
            
            Text(statName)
                .frame(width: 50, alignment: .leading)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(.white)

                    Rectangle()
                        .foregroundStyle(statColor)
                        .frame(width: geo.size.width * (statValue / statMax))
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.black, lineWidth: 2)
                )
            }
            .frame(height: 15)
            
            Text("\(Int(statValue))")
                .frame(width: 50, alignment: .trailing)

        }
        .fontWeight(.bold)
        .padding(.horizontal)
    }
}
