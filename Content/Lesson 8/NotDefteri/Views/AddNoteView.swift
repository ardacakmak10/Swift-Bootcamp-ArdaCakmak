import SwiftUI

struct AddNoteView: View {
    @EnvironmentObject var viewModel: NotesViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var content = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Başlık")) {
                    TextField("Not başlığı", text: $title)
                }

                Section(header: Text("İçerik")) {
                    TextEditor(text: $content)
                        .frame(minHeight: 200)
                }
            }
            .navigationTitle("Yeni Not")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        saveNote()
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                              content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func saveNote() {
        let t = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let c = content.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !t.isEmpty || !c.isEmpty else { return }
        viewModel.addNote(title: t.isEmpty ? "Başlıksız Not" : t, content: c)
    }
}

#Preview {
    AddNoteView()
        .environmentObject(NotesViewModel())
}
