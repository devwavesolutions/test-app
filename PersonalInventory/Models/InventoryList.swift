import Foundation

struct InventoryList: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String
    var itemIDs: [UUID]
    var createdAt: Date

    init(id: UUID = UUID(), name: String, itemIDs: [UUID] = [], createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.itemIDs = itemIDs
        self.createdAt = createdAt
    }
}
