//
//  NavigationBar.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 08/12/2025.
//

import SwiftUI

struct NavigationBar: View {
    private var title: String
    private var buttons: [NavigationBarItem]
    private var isWhiteFont: Bool
    private var backgroundColor: Color
    
    init(title: String, buttons: [NavigationBarItem] = [], isWhiteFont: Bool = false, backgroundColor: Color = .white) {
        self.title = title
        self.buttons = buttons
        self.isWhiteFont = isWhiteFont
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        HStack {
            Image("navBarPokeball")
                .resizable()
                .frame(width: 24, height: 24)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            ForEach(buttons, id: \.self) { button in
                VStack(spacing: 0) {
                    Image(systemName: button.image)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(button.name)
                        .font(.caption2)
                }
                .frame(width: 40)
                .onTapGesture {
                    button.action()
                }
            }
        }
        .padding(.horizontal)
        .foregroundStyle(isWhiteFont ? .white : .black)
        .background(backgroundColor)
    }
}

#Preview {
    NavigationBar(title: "Pokedex", 
                  buttons: [
                    NavigationBarItem(name: "Search", 
                                      image: "magnifyingglass",
                                      action: {}),
                    NavigationBarItem(name: "Favourites", 
                                      image: "heart",
                                      action: {})
                  ], isWhiteFont: true, backgroundColor: .red)
}
