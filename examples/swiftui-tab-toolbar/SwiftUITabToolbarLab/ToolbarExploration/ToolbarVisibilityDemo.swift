import SwiftUI

/// Toolbar Visibility Demo
/// Demonstrates showing/hiding toolbars and controlling background visibility
/// Use this for: Immersive views, custom chrome, full-screen experiences
/// Key features:
/// - .toolbar(_:for:) shows/hides specific bars
/// - .toolbarBackgroundVisibility(_:for:) controls background blur
/// - Targets: .navigationBar, .tabBar, .bottomBar
/// - Useful for clean, distraction-free UIs
struct ToolbarVisibilityDemo: View {
    @State private var hideNavigation = false
    @State private var hideBackground = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear.styledTabContent("Visibility Demo")

                VStack(spacing: 20) {
                    Toggle("Hide Navigation Bar", isOn: $hideNavigation)
                        .padding()

                    Toggle("Hide Navigation Background", isOn: $hideBackground)
                        .padding()

                    Text("Scroll to see background effects")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Visibility")
            // THIS IS KEY: Control toolbar visibility
            // .hidden, .visible, .automatic
            .toolbar(hideNavigation ? .hidden : .visible, for: .navigationBar)
            // THIS IS KEY: Control background visibility
            // Useful for translucent or invisible navigation bars
            .toolbarBackgroundVisibility(
                hideBackground ? .hidden : .automatic,
                for: .navigationBar
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        hideNavigation = false
                        hideBackground = false
                    }
                }
            }
        }
    }
}

#Preview {
    ToolbarVisibilityDemo()
}
