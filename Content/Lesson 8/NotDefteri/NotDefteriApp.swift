import SwiftUI

@main
struct NotDefteriApp: App {
    @StateObject private var viewModel = NotesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
