import SwiftUI

/// Toolbar with Bottom Search (iOS 26+)
/// Demonstrates search field in bottom toolbar using iOS 26 APIs
/// Use this for: Apps with search + bottom toolbar actions
/// Key features:
/// - DefaultToolbarItem(kind: .search) places search at bottom
/// - Works with .searchable() modifier
/// - Liquid Glass container on iPhone (bottom) and iPad (top trailing)
/// - System handles layout and spacing automatically
/// - Shows/hides search based on filter button toggle
struct ToolbarSearchDemo: View {
    @State private var query = ""
    @State private var showSearch = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear.styledTabContent("Bottom Search Demo")

                VStack {
                    if !query.isEmpty {
                        List(filteredResults, id: \.self) { item in
                            Text(item)
                                .listRowBackground(Color.clear)
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("Search")
            // THIS IS KEY: .searchable() provides search functionality
            // Combined with DefaultToolbarItem below for bottom placement
            .searchable(text: $query, prompt: Text("Search items"))
            .toolbar {
                // THIS IS KEY: iOS 26+ API for bottom search placement
                // DefaultToolbarItem(kind: .search) allocates space in bottom toolbar
                // Shows in Liquid Glass container
                // Only visible when showSearch is true
                if #available(iOS 26.0, *) {
                    if showSearch {
                        DefaultToolbarItem(kind: .search, placement: .bottomBar)
                        ToolbarSpacer(.flexible, placement: .bottomBar)
                    } else {
                        ToolbarSpacer(.flexible, placement: .bottomBar)
                    }
                }

                // Other bottom toolbar items
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showSearch.toggle()
                        if !showSearch {
                            query = ""
                        }
                    } label: {
                        Image(systemName: showSearch ? "xmark" : "magnifyingglass")
                    }
                }
            }
        }
    }

    private var filteredResults: [String] {
        items.filter { query.isEmpty ? true : $0.localizedCaseInsensitiveContains(query) }
    }

    private let items = (1...50).map { "Item \($0)" }
}

#Preview {
    ToolbarSearchDemo()
}
