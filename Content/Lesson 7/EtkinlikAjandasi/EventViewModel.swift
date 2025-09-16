import Foundation

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    func addEvent(title: String, date: Date, type: EventType, hasReminder: Bool) {
        let newEvent = Event(title: title, date: date, type: type, hasReminder: hasReminder)
        events.append(newEvent)
    }
    
    func deleteEvent(event: Event) {
        events.removeAll { $0.id == event.id }
    }
    
    func toggleReminder(for event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index].hasReminder.toggle()
        }
    }
    
    // ✅ Güncelleme işlemleri
    func updateEvent(event: Event, newTitle: String, newDate: Date, newType: EventType) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index].title = newTitle
            events[index].date = newDate
            events[index].type = newType
        }
    }
    
    func toggleCompleted(for event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index].isCompleted.toggle()
        }
    }
}
