import Foundation
import Combine

final class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [Task] = []
    @Published var newTitle: String = ""

    func addTask() {
        let trimmed = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        tasks.insert(Task(title: trimmed), at: 0)
        newTitle = ""
    }

    func toggle(_ task: Task) {
        guard let idx = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[idx].isCompleted.toggle()
    }

    func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    init(preview: Bool = false) {
        if preview {
            self.tasks = [
                Task(title: "SwiftUI ödevi"),
                Task(title: "Lesson.05", isCompleted: true),
                Task(title: "Lesson.06")
            ]
        }
    }
}
