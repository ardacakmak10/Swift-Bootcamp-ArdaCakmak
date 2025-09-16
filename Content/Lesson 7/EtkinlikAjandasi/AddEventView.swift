import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: EventViewModel
    
    @State private var title = ""
    @State private var date = Date()
    @State private var type: EventType = .diger
    @State private var hasReminder = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Etkinlik Bilgileri")) {
                    TextField("Etkinlik adı", text: $title)
                    DatePicker("Tarih", selection: $date, displayedComponents: .date)
                    Picker("Tür", selection: $type) {
                        ForEach(EventType.allCases) { eventType in
                            Text(eventType.rawValue).tag(eventType)
                        }
                    }
                    Toggle("Hatırlatıcı", isOn: $hasReminder)
                }
            }
            .navigationTitle("Yeni Etkinlik")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Vazgeç") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        viewModel.addEvent(title: title, date: date, type: type, hasReminder: hasReminder)
                        dismiss()
                    }
                }
            }
        }
    }
}
