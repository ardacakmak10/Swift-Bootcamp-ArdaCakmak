import SwiftUI

struct TaskRowView: View {
    let task: Task
    let toggleAction: () -> Void

    var body: some View {
        HStack {
            Button(action: toggleAction) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .imageScale(.large)
            }
            .buttonStyle(.plain)

            Text(task.title)
                .strikethrough(task.isCompleted, color: .secondary)
                .foregroundColor(task.isCompleted ? .secondary : .primary)
                .animation(.default, value: task.isCompleted)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: toggleAction)
    }
}

#Preview {
    TaskRowView(task: Task(title: "Örnek Görev"), toggleAction: {})
        .padding()
}
