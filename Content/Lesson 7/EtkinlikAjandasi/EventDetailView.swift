import SwiftUI

struct EventDetailView: View {
    @ObservedObject var viewModel: EventViewModel
    var event: Event
    @Environment(\.dismiss) var dismiss
    
    @State private var isEditing = false
    @State private var newTitle: String = ""
    @State private var newDate: Date = Date()
    @State private var newType: EventType = .diger
    
    var body: some View {
        VStack(spacing: 20) {
            if isEditing {
                // ✅ Düzenleme Formu
                TextField("Etkinlik adı", text: $newTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                DatePicker("Tarih", selection: $newDate, displayedComponents: .date)
                    .padding()
                
                Picker("Tür", selection: $newType) {
                    ForEach(EventType.allCases) { eventType in
                        Text(eventType.rawValue).tag(eventType)
                    }
                }
                .padding()
                
                Button("Kaydet") {
                    viewModel.updateEvent(event: event, newTitle: newTitle, newDate: newDate, newType: newType)
                    isEditing = false
                }
                .buttonStyle(.borderedProminent)
                
            } else {
                // ✅ Normal görüntüleme
                Text(event.title)
                    .font(.largeTitle)
                    .bold()
                Text("Tarih: \(event.date.formatted(date: .abbreviated, time: .omitted))")
                Text("Tür: \(event.type.rawValue)")
                
                Toggle("Hatırlatıcı", isOn: Binding(
                    get: { event.hasReminder },
                    set: { _ in viewModel.toggleReminder(for: event) }
                ))
                .padding()
                
                Toggle("Tamamlandı", isOn: Binding(
                    get: { event.isCompleted },
                    set: { _ in viewModel.toggleCompleted(for: event) }
                ))
                .padding()
                
                Button("Düzenle") {
                    newTitle = event.title
                    newDate = event.date
                    newType = event.type
                    isEditing = true
                }
                .buttonStyle(.bordered)
            }
            
            Button(role: .destructive) {
                viewModel.deleteEvent(event: event)
                dismiss()
            } label: {
                Text("Etkinliği Sil").bold()
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Etkinlik Detayı")
    }
}
