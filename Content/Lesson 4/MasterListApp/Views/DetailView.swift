//
//  DetailView.swift
//  MasterListApp
//
//  Created by Arda Çakmak on 8.09.2025.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: ListViewModel
    let item: TodoItem
    @State private var symbol: String = ""

    let symbols = ["star.fill", "heart.fill", "bolt.fill", "leaf.fill", "paperplane.fill", "sun.max.fill", "moon.fill", "flame.fill", "gift.fill", "bell.fill"]

    var body: some View {
        VStack(spacing: 20) {
            if !symbol.isEmpty {
                Image(systemName: symbol)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
            }

            Text(item.title).font(.title).bold().multilineTextAlignment(.center)
            Text(item.detail).font(.body).foregroundColor(.secondary).multilineTextAlignment(.leading).padding()

            Spacer()

            Button(action: { viewModel.toggleComplete(item.id) }) {
                Label(item.isCompleted ? "Tamamlamayı Geri Al" : "Tamamlandı olarak işaretle", systemImage: item.isCompleted ? "arrow.uturn.left" : "checkmark")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("Detay")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { symbol = symbols.randomElement() ?? "star.fill" }
    }
}
