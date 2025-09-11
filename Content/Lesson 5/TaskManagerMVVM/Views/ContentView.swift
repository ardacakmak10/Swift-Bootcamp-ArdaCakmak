import SwiftUI

struct ContentView: View {
    @StateObject private var vm: TaskViewModel

    init(viewModel: TaskViewModel = TaskViewModel()) {
        _vm = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                HStack {
                    TextField("Yeni görev başlığı...", text: $vm.newTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .submitLabel(.done)
                        .onSubmit { vm.addTask() }

                    Button(action: vm.addTask) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .disabled(vm.newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)

                if vm.tasks.isEmpty {
                    VStack(spacing: 8) {
                        Image(systemName: "checklist")
                            .font(.largeTitle)
                        Text("Görev yok")
                            .font(.headline)
                        Text("Yeni görev ekleyerek başlayın.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(vm.tasks) { task in
                            TaskRowView(task: task) {
                                vm.toggle(task)
                            }
                        }
                        .onDelete(perform: vm.delete)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Görevler")
        }
    }
}

#Preview {
    ContentView(viewModel: TaskViewModel(preview: true))
}
