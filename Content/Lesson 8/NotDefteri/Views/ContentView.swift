import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: NotesViewModel
    @State private var showAddSheet = false
    @State private var selection = Set<UUID>()
    @Environment(\.editMode) private var editMode

    var body: some View {
        NavigationView {
            List(selection: $selection) {
                if viewModel.notes.isEmpty {
                    Text("Henüz not yok. + ile yeni not ekleyin.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(viewModel.notes) { note in
                        NavigationLink(destination: NoteDetailView(note: note)) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(note.title)
                                    .font(.headline)
                                Text(note.content)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(format(date: note.date))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .onDelete { offsets in
                        viewModel.delete(at: offsets)
                    }
                    .onMove { indices, newOffset in
                        viewModel.move(from: indices, to: newOffset)
                    }
                }
            }
            .navigationTitle("Not Defteri")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        if editMode?.wrappedValue == .active && !selection.isEmpty {
                            Button("Toplu Sil") {
                                viewModel.deleteMultiple(ids: selection)
                                selection.removeAll()
                            }
                        }
                        Button {
                            showAddSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddNoteView()
                    .environmentObject(viewModel)
            }
        }
    }

    private func format(date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df.string(from: date)
    }
}

#Preview {
    ContentView()
        .environmentObject(NotesViewModel())
}
