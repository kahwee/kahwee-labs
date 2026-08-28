import SwiftUI

/// Complete Toolbar Showcase
/// Combines all toolbar patterns: corners, search, overflow, bottom bar
/// Use this for: Understanding comprehensive toolbar capabilities
/// Key features:
/// - Multiple placements working together
/// - Search integration
/// - Overflow handling
/// - Bottom bar with status
/// - System adapts layout automatically
struct ToolbarShowcase: View {
    @State private var query = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear.styledTabContent("Toolbar Showcase")

                VStack {
                    if !query.isEmpty {
                        List(filtered, id: \.self) { item in
                            Text(item)
                                .listRowBackground(Color.clear)
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("Toolbar Showcase")
            // Search integrates with navigation bar
            .searchable(text: $query, prompt: Text("Search demo"))
            .toolbar {
                // Top-left
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // Menu
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }

                // Top-right with multiple items
                // System handles overflow on smaller screens
                ToolbarItemGroup(placement: .topBarTrailing) {
                    ForEach(1...10, id: \.self) { i in
                        Button {
                            // Action \(i)
                        } label: {
                            Image(systemName: "\(i).circle")
                        }
                    }
                }

                // Bottom bar layout
                // System balances items across bottom bar
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        // Previous
                    } label: {
                        Label("Prev", systemImage: "chevron.backward")
                    }
                }

                // Centered status in bottom bar
                ToolbarItem(placement: .status) {
                    Text("Page 3 of 10")
                        .font(.footnote)
                }

                ToolbarItem(placement: .bottomBar) {
                    Button {
                        // Next
                    } label: {
                        Label("Next", systemImage: "chevron.forward")
                    }
                }
            }
        }
    }

    var filtered: [String] {
        let data = (1...100).map { "Item \($0)" }
        return query.isEmpty ? data : data.filter { $0.localizedCaseInsensitiveContains(query) }
    }
}

#Preview {
    ToolbarShowcase()
}
