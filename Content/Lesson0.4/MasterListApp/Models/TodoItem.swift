import Foundation

struct TodoItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var detail: String
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, detail: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.detail = detail
        self.isCompleted = isCompleted
    }
}
