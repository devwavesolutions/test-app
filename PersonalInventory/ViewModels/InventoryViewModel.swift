import Foundation

@MainActor
final class InventoryViewModel: ObservableObject {
    @Published private(set) var items: [InventoryItem] = []
    @Published private(set) var lists: [InventoryList] = []
    @Published var searchText: String = ""
    @Published var selectedCategory: ItemCategory?

    private let store = InventoryStore()

    init() {
        loadData()
    }

    var filteredItems: [InventoryItem] {
        let normalizedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        return items
            .filter { item in
                let categoryMatch = selectedCategory == nil || item.category == selectedCategory
                let searchMatch = normalizedQuery.isEmpty ||
                    item.name.lowercased().contains(normalizedQuery) ||
                    item.location.lowercased().contains(normalizedQuery) ||
                    item.notes.lowercased().contains(normalizedQuery) ||
                    item.tags.joined(separator: " ").lowercased().contains(normalizedQuery)
                return categoryMatch && searchMatch
            }
            .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }

    var favoriteItems: [InventoryItem] {
        items.filter(\.isFavorite)
    }

    var lowStockItems: [InventoryItem] {
        items.filter(\.isLowStock)
    }

    func addItem(_ item: InventoryItem) {
        items.append(item)
        saveData()
    }

    func updateItem(_ item: InventoryItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index] = item
        items[index].updatedAt = Date()
        saveData()
    }

    func deleteItems(at offsets: IndexSet, in filtered: [InventoryItem]) {
        let idsToDelete = offsets.map { filtered[$0].id }
        items.removeAll { idsToDelete.contains($0.id) }
        lists = lists.map { list in
            var copy = list
            copy.itemIDs.removeAll { idsToDelete.contains($0) }
            return copy
        }
        saveData()
    }

    func deleteItem(id: UUID) {
        items.removeAll { $0.id == id }
        lists = lists.map { list in
            var copy = list
            copy.itemIDs.removeAll { $0 == id }
            return copy
        }
        saveData()
    }

    func toggleFavorite(itemID: UUID) {
        guard let index = items.firstIndex(where: { $0.id == itemID }) else { return }
        items[index].isFavorite.toggle()
        items[index].updatedAt = Date()
        saveData()
    }

    func addList(name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        lists.append(InventoryList(name: trimmed))
        saveData()
    }

    func deleteLists(at offsets: IndexSet) {
        lists.remove(atOffsets: offsets)
        saveData()
    }

    func listItems(for list: InventoryList) -> [InventoryItem] {
        items.filter { list.itemIDs.contains($0.id) }
            .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }

    func toggleItem(_ itemID: UUID, in listID: UUID) {
        guard let index = lists.firstIndex(where: { $0.id == listID }) else { return }

        if lists[index].itemIDs.contains(itemID) {
            lists[index].itemIDs.removeAll { $0 == itemID }
        } else {
            lists[index].itemIDs.append(itemID)
        }

        saveData()
    }

    private func loadData() {
        let data = store.load()
        items = data.items
        lists = data.lists
    }

    private func saveData() {
        store.save(items: items, lists: lists)
    }
}
