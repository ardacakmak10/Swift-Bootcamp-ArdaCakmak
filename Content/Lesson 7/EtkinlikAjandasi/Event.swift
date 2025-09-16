import Foundation

struct Event: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var date: Date
    var type: EventType
    var hasReminder: Bool
    var isCompleted: Bool = false   
}

enum EventType: String, CaseIterable, Identifiable {
    case dogumGunu = "Doğum Günü"
    case toplantı = "Toplantı"
    case tatil = "Tatil"
    case spor = "Spor"
    case diger = "Diğer"
    
    var id: String { self.rawValue }
}
