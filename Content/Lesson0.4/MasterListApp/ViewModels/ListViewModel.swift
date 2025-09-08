import Foundation
import SwiftUI

@MainActor
class ListViewModel: ObservableObject {
    @Published var items: [TodoItem] = []
    @Published var themeColor: Color = .blue
    @Published var useLazyStack: Bool = false

    private let colors: [Color] = [.blue, .green, .orange, .purple, .pink, .teal, .red, .yellow]

    init() {
        generateSampleItems()
        applyRandomTheme()
    }

    func generateSampleItems() {
        items = (1...10).map { i in
            TodoItem(title: "Öğe \(i)", detail: "Bu, öğe \(i) için açıklamadır.", isCompleted: i % 4 == 0)
        }
    }

    func addItem(title: String, detail: String) {
        let new = TodoItem(title: title, detail: detail, isCompleted: false)
        items.insert(new, at: 0)
    }

    func delete(ids: [UUID]) {
        for id in ids {
            if let idx = items.firstIndex(where: { $0.id == id }) {
                items.remove(at: idx)
            }
        }
    }

    func toggleComplete(_ id: UUID) {
        if let idx = items.firstIndex(where: { $0.id == id }) {
            items[idx].isCompleted.toggle()
        }
    }

    func applyRandomTheme() {
        themeColor = colors.randomElement() ?? .blue
    }
}
