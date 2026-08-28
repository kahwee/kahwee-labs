import SwiftUI

/// Basic Toolbar Demo
/// Demonstrates the simplest toolbar setup with a single item
/// Use this for: Learning toolbar basics, simple apps
/// Key features:
/// - Single ToolbarItem in top-right corner
/// - Must be inside NavigationStack for toolbar to appear
/// - placement parameter tells SwiftUI where you want it
struct BasicToolbarDemo: View {
    var body: some View {
        NavigationStack {
            Color.clear.styledTabContent("Basic Toolbar")
                .navigationTitle("Basic Toolbar")
                .toolbar {
                    // Single toolbar item in top-right
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            print("Add tapped")
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
    }
}

#Preview {
    BasicToolbarDemo()
}
