//
//  HomeView.swift
//  Sergei
//
//  Created by Hidemasa Kobayashi on 2025/06/21.
//

import SwiftUI

struct HomeView: View {
    private let items = Array(1...20)
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items, id: \.self) { item in
                    Text("Item \(item)")
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
