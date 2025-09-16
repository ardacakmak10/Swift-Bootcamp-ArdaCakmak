import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = EventViewModel()
    @State private var showAddEvent = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.events) { event in
                    NavigationLink(destination: EventDetailView(viewModel: viewModel, event: event)) {
                        VStack(alignment: .leading) {
                            Text(event.title)
                                .font(.headline)
                                .strikethrough(event.isCompleted) // ✅ tamamlandıysa üstü çizili
                                .foregroundColor(event.isCompleted ? .gray : .primary)
                            
                            Text(event.date.formatted(date: .abbreviated, time: .omitted))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(event.type.rawValue)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Etkinlik Ajandası")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddEvent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddEvent) {
                AddEventView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
