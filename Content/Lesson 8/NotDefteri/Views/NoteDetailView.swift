import SwiftUI

struct NoteDetailView: View {
    let note: Note

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(note.title)
                    .font(.title)
                    .bold()
                Text(format(date: note.date))
                    .font(.caption)
                    .foregroundColor(.secondary)
                Divider()
                Text(note.content)
                    .font(.body)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Not")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func format(date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df.string(from: note.date)
    }
}

#Preview {
    NoteDetailView(note: Note(title: "Örnek Not", content: "Detay ekranı önizleme."))
}
