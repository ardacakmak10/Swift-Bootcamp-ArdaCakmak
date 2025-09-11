import SwiftUI

@main
struct MasterListAppApp: App {
    @StateObject private var viewModel = ListViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
