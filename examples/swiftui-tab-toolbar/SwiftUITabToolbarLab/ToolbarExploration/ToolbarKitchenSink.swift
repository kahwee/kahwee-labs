import SwiftUI

/// Toolbar Kitchen Sink Demo
/// Demonstrates ALL toolbar placements in one comprehensive example
/// Use this for: Understanding all available toolbar placement options
/// Key features:
/// - .topBarLeading: Top-left corner (menu/navigation)
/// - .topBarTrailing: Top-right corner (primary actions)
/// - .title: Custom title view in navigation bar
/// - .subtitle: Subtitle text below title
/// - .bottomBar: Bottom toolbar actions (left and right)
/// - .status: Centered bottom status (can be button or text)
/// This is a kitchen sink demo - not recommended for production
struct ToolbarKitchenSink: View {
    @State private var selectedCount = 3
    private let people = DemoData.generatePeople()

    var body: some View {
        NavigationStack {
            List(people, id: \.self) { person in
                Text(person)
            }
            .navigationTitle("Four Corners")
            .toolbar {
                // Top-left corner
                // Common for: Menu, back navigation, sidebar toggle
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // Menu action
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }

                // Top-right corner
                // Common for: Add, edit, share, primary actions
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Add action
                    } label: {
                        Image(systemName: "plus")
                    }
                }

                // Bottom bar left side
                // System places this on the left
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        // Back action
                    } label: {
                        Label("Back", systemImage: "chevron.backward")
                    }
                }

                ToolbarItem(placement: .title) {
                    HStack(spacing: 6) {
                        Image(systemName: "tray.fill")
                        Text("Inbox")
                    }
                }
                ToolbarItem(placement: .subtitle) {
                    Text("\(selectedCount) of \(people.count) people selected")
                        .foregroundStyle(.secondary)
                }
                // THIS IS KEY: .status places item in center of bottom bar
                // Used for: Non-interactive status text, page indicators
                // Like Files app showing "3 of 12 items selected"
                ToolbarItem(placement: .status) {
                    Button {
                        // e.g., open a selection panel or show details
                    } label: {
                        Text("\(selectedCount) of \(people.count) people selected")
                    }
                    .controlSize(.large)
                }

                // Bottom bar right side
                // System places this on the right to balance with left item
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        // Next action
                    } label: {
                        Label("Next", systemImage: "chevron.forward")
                    }
                }
            }
        }
    }
}

#Preview {
    ToolbarKitchenSink()
}
