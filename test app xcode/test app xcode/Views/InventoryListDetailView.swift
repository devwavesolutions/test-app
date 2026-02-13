import SwiftUI

struct InventoryListDetailView: View {
    @EnvironmentObject private var viewModel: InventoryViewModel
    let list: InventoryList

    private var currentList: InventoryList? {
        viewModel.lists.first(where: { $0.id == list.id })
    }

    var body: some View {
        List {
            if viewModel.items.isEmpty {
                Text("No items available yet. Add inventory items first.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.items.sorted(by: { $0.name < $1.name })) { item in
                    Button {
                        viewModel.toggleItem(item.id, in: list.id)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(item.name)
                                    .foregroundStyle(.primary)
                                Text("\(item.category.title) • Qty \(item.quantity)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: (currentList?.itemIDs.contains(item.id) ?? false) ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle((currentList?.itemIDs.contains(item.id) ?? false) ? .green : .secondary)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle(list.name)
    }
}
