import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            InventoryItemsView()
                .tabItem {
                    Label("Items", systemImage: "shippingbox.fill")
                }

            InventoryListsView()
                .tabItem {
                    Label("Lists", systemImage: "list.bullet.rectangle")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(InventoryViewModel())
}
