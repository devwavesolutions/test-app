import SwiftUI

@main
struct test_app_xcodeApp: App {
    @StateObject private var viewModel = InventoryViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
