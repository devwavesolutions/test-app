import SwiftUI

struct ContentView: View {
    @State private var selectedTab: AppTab = .home

    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                DashboardView()
            case .items:
                InventoryItemsView()
            case .lists:
                InventoryListsView()
            case .search:
                SearchView()
            }
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 12)
                .padding(.top, 8)
                .background(.clear)
        }
    }
}

private enum AppTab {
    case home
    case items
    case lists
    case search
}

private struct CustomTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 4) {
                TabButton(
                    title: "Home",
                    systemImage: "house.fill",
                    isSelected: selectedTab == .home
                ) {
                    selectedTab = .home
                }

                TabButton(
                    title: "Items",
                    systemImage: "shippingbox.fill",
                    isSelected: selectedTab == .items
                ) {
                    selectedTab = .items
                }

                TabButton(
                    title: "Lists",
                    systemImage: "list.bullet.rectangle",
                    isSelected: selectedTab == .lists
                ) {
                    selectedTab = .lists
                }
            }

            Spacer(minLength: 18)

            TabButton(
                title: "Search",
                systemImage: "magnifyingglass",
                isSelected: selectedTab == .search
            ) {
                selectedTab = .search
            }
        }
        .padding(8)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .strokeBorder(.white.opacity(0.22), lineWidth: 0.5)
        )
    }
}

private struct TabButton: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.system(size: 16, weight: .semibold))
                Text(title)
                    .font(.caption2)
            }
            .foregroundStyle(isSelected ? .primary : .secondary)
            .frame(minWidth: 58, minHeight: 44)
            .padding(.horizontal, 8)
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.accentColor.opacity(0.18))
                }
            }
        }
        .buttonStyle(.plain)
    }
}
