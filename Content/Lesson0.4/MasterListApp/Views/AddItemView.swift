import SwiftUI

struct AddItemView: View {
    @EnvironmentObject var viewModel: ListViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var detail = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Başlık", text: $title)
                    TextField("Açıklama", text: $detail)
                }

                Section {
                    Button("Kaydet") {
                        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !trimmedTitle.isEmpty {
                            viewModel.addItem(title: trimmedTitle, detail: detail.trimmingCharacters(in: .whitespacesAndNewlines))
                            dismiss()
                        }
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .navigationTitle("Yeni Öğe Ekle")
            .toolbar { ToolbarItem(placement: .navigationBarLeading) { Button("İptal") { dismiss() } } }
        }
    }
}
