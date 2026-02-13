import Foundation

struct InventoryItem: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String
    var category: ItemCategory
    var quantity: Int
    var location: String
    var notes: String
    var tags: [String]
    var isFavorite: Bool
    var createdAt: Date
    var updatedAt: Date

    var isLowStock: Bool {
        quantity <= 2
    }

    init(
        id: UUID = UUID(),
        name: String,
        category: ItemCategory,
        quantity: Int = 1,
        location: String = "",
        notes: String = "",
        tags: [String] = [],
        isFavorite: Bool = false,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.quantity = quantity
        self.location = location
        self.notes = notes
        self.tags = tags
        self.isFavorite = isFavorite
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

enum ItemCategory: String, Codable, CaseIterable, Identifiable {
    case groceries
    case household
    case electronics
    case clothing
    case personalCare
    case office
    case other

    var id: String { rawValue }

    var title: String {
        switch self {
        case .groceries: return "Groceries"
        case .household: return "Household"
        case .electronics: return "Electronics"
        case .clothing: return "Clothing"
        case .personalCare: return "Personal Care"
        case .office: return "Office"
        case .other: return "Other"
        }
    }
}
