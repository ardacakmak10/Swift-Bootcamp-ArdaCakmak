import Foundation

class NotesViewModel: ObservableObject {
    @Published private(set) var notes: [Note] = []

    private let notesKey = "notes_key"

    init() {
        load()
    }

    func add(note: Note) {
        notes.append(note)
        save()
    }

    func addNote(title: String, content: String) {
        let newNote = Note(
            id: UUID(),
            title: title,
            content: content,
            date: Date()
        )
        add(note: newNote)
    }

    func delete(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        save()
    }

    func deleteMultiple(ids: Set<UUID>) {
        notes.removeAll { ids.contains($0.id) }
        save()
    }

    func move(from source: IndexSet, to destination: Int) {
        notes.move(fromOffsets: source, toOffset: destination)
        save()
    }

    func saveManually() {
        save()
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: notesKey)
        }
    }

    private func load() {
        if let savedData = UserDefaults.standard.data(forKey: notesKey),
           let decoded = try? JSONDecoder().decode([Note].self, from: savedData) {
            notes = decoded
        }
    }
}
