import Foundation

struct InventoryStore {
    struct PersistedData: Codable {
        var items: [InventoryItem]
        var lists: [InventoryList]
    }

    private let fileName = "inventory_data.json"

    func load() -> PersistedData {
        let url = dataURL()
        guard
            let data = try? Data(contentsOf: url),
            let decoded = try? JSONDecoder().decode(PersistedData.self, from: data)
        else {
            return PersistedData(items: [], lists: [])
        }

        return decoded
    }

    func save(items: [InventoryItem], lists: [InventoryList]) {
        let payload = PersistedData(items: items, lists: lists)

        guard let data = try? JSONEncoder().encode(payload) else {
            return
        }

        try? data.write(to: dataURL(), options: .atomic)
    }

    private func dataURL() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            ?? FileManager.default.temporaryDirectory
        return documentDirectory.appendingPathComponent(fileName)
    }
}
