import SwiftUI

struct InventoryItemsView: View {
    @EnvironmentObject private var viewModel: InventoryViewModel
    @State private var showingCreateSheet = false
    @State private var editingItem: InventoryItem?

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Category", selection: $viewModel.selectedCategory) {
                        Text("All Categories").tag(ItemCategory?.none)
                        ForEach(ItemCategory.allCases) { category in
                            Text(category.title).tag(Optional(category))
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section("Items") {
                    if viewModel.filteredItems.isEmpty {
                        Text("No items yet")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(viewModel.filteredItems) { item in
                            ItemRow(item: item, onFavorite: {
                                viewModel.toggleFavorite(itemID: item.id)
                            })
                            .contentShape(Rectangle())
                            .onTapGesture {
                                editingItem = item
                            }
                        }
                        .onDelete { offsets in
                            viewModel.deleteItems(at: offsets, in: viewModel.filteredItems)
                        }
                    }
                }
            }
            .navigationTitle("Items")
            .searchable(text: $viewModel.searchText, prompt: "Search inventory")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingCreateSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateSheet) {
                ItemEditorView(mode: .create) { item in
                    viewModel.addItem(item)
                }
            }
            .sheet(item: $editingItem) { item in
                ItemEditorView(mode: .edit(item)) { updated in
                    viewModel.updateItem(updated)
                }
            }
        }
    }
}

private struct ItemRow: View {
    let item: InventoryItem
    let onFavorite: () -> Void

    var body: some View {
        HStack {
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
            Spacer()
            Button(action: onFavorite) {
                Image(systemName: item.isFavorite ? "star.fill" : "star")
                    .foregroundStyle(item.isFavorite ? .yellow : .secondary)
            }
            .buttonStyle(.plain)
        }
    }
}
