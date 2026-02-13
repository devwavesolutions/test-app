import SwiftUI

@main
struct PersonalInventoryApp: App {
    @StateObject private var viewModel = InventoryViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
