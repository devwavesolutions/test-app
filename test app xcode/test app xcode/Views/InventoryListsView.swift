import SwiftUI

struct InventoryListsView: View {
    @EnvironmentObject private var viewModel: InventoryViewModel
    @State private var showingAddAlert = false
    @State private var newListName = ""

    var body: some View {
        NavigationStack {
            List {
                if viewModel.lists.isEmpty {
                    Text("No lists yet. Tap + to create one.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(viewModel.lists) { list in
                        NavigationLink(destination: InventoryListDetailView(list: list)) {
                            HStack {
                                Text(list.name)
                                Spacer()
                                Text("\(viewModel.listItems(for: list).count)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteLists)
                }
            }
            .navigationTitle("Lists")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddAlert = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("New List", isPresented: $showingAddAlert) {
                TextField("List Name", text: $newListName)
                Button("Cancel", role: .cancel) {
                    newListName = ""
                }
                Button("Create") {
                    viewModel.addList(name: newListName)
                    newListName = ""
                }
            } message: {
                Text("Create a list to group items.")
            }
        }
    }
}
