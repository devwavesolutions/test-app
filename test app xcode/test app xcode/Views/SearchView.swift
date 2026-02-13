import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var viewModel: InventoryViewModel

    var body: some View {
        NavigationStack {
            List {
                if viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Section {
                        Text("Start typing to search your inventory.")
                            .foregroundStyle(.secondary)
                    }
                } else if viewModel.filteredItems.isEmpty {
                    Section {
                        Text("No matching items.")
                            .foregroundStyle(.secondary)
                    }
                } else {
                    Section("Results") {
                        ForEach(viewModel.filteredItems) { item in
                            SearchResultRow(item: item)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchText, prompt: "Search inventory")
            .onAppear {
                viewModel.selectedCategory = nil
            }
        }
    }
}

private struct SearchResultRow: View {
    let item: InventoryItem

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.name)
                .font(.headline)
            Text("\(item.category.title) • Qty \(item.quantity)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if !item.location.isEmpty {
                Text(item.location)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
