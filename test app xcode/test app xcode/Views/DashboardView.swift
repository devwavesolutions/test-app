import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var viewModel: InventoryViewModel

    var body: some View {
        NavigationStack {
            List {
                Section("Overview") {
                    StatRow(title: "Total Items", value: "\(viewModel.items.count)", systemImage: "shippingbox.fill")
                    StatRow(title: "Favorites", value: "\(viewModel.favoriteItems.count)", systemImage: "star.fill")
                    StatRow(title: "Low Stock", value: "\(viewModel.lowStockItems.count)", systemImage: "exclamationmark.triangle.fill")
                    StatRow(title: "Lists", value: "\(viewModel.lists.count)", systemImage: "list.bullet.rectangle")
                }

                if !viewModel.lowStockItems.isEmpty {
                    Section("Low Stock") {
                        ForEach(viewModel.lowStockItems.prefix(5)) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text("Qty \(item.quantity)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Inventory")
        }
    }
}

private struct StatRow: View {
    let title: String
    let value: String
    let systemImage: String

    var body: some View {
        HStack {
            Label(title, systemImage: systemImage)
            Spacer()
            Text(value)
                .bold()
        }
    }
}
