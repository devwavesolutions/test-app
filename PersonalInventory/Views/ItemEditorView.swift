import SwiftUI

struct ItemEditorView: View {
    enum Mode {
        case create
        case edit(InventoryItem)
    }

    @Environment(\.dismiss) private var dismiss

    let mode: Mode
    let onSave: (InventoryItem) -> Void

    @State private var name: String = ""
    @State private var category: ItemCategory = .other
    @State private var quantity: Int = 1
    @State private var location: String = ""
    @State private var notes: String = ""
    @State private var tagsText: String = ""
    @State private var isFavorite: Bool = false

    private var editItem: InventoryItem? {
        if case let .edit(item) = mode {
            return item
        }
        return nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                    Picker("Category", selection: $category) {
                        ForEach(ItemCategory.allCases) { item in
                            Text(item.title).tag(item)
                        }
                    }
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 0...999)
                }

                Section("Organization") {
                    TextField("Location", text: $location)
                    TextField("Tags (comma-separated)", text: $tagsText)
                    Toggle("Favorite", isOn: $isFavorite)
                }

                Section("Notes") {
                    TextField("Any extra info", text: $notes, axis: .vertical)
                        .lineLimit(3...8)
                }
            }
            .navigationTitle(editItem == nil ? "New Item" : "Edit Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .onAppear(perform: loadState)
        }
    }

    private func loadState() {
        guard let item = editItem else { return }
        name = item.name
        category = item.category
        quantity = item.quantity
        location = item.location
        notes = item.notes
        tagsText = item.tags.joined(separator: ", ")
        isFavorite = item.isFavorite
    }

    private func save() {
        let tags = tagsText
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        let savedItem = InventoryItem(
            id: editItem?.id ?? UUID(),
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            category: category,
            quantity: quantity,
            location: location.trimmingCharacters(in: .whitespacesAndNewlines),
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines),
            tags: tags,
            isFavorite: isFavorite,
            createdAt: editItem?.createdAt ?? Date(),
            updatedAt: Date()
        )

        onSave(savedItem)
        dismiss()
    }
}
