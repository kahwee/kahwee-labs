import SwiftUI

/// Basic TabView example using iOS 26's Tab API
/// Demonstrates four tabs with a rainbow gradient background
struct TabViewExample: View {
    /// Main view body containing TabView with four tabs including Search
    /// iOS 26+ Tab API: Clean, declarative syntax
    /// TabView automatically handles:
    /// - State persistence (remembers selected tab)
    /// - Smooth animations between tabs
    /// - Accessibility (VoiceOver, Dynamic Type)
    /// - Platform conventions (iOS design guidelines)
    /// - Liquid glass effect on tab bar (iOS 26+)
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                Color.clear.styledTabContent("Home")
            }

            Tab("Automation", systemImage: "checkmark.circle") {
                Color.clear.styledTabContent("Automation")
            }

            Tab("Discover", systemImage: "star") {
                Color.clear.styledTabContent("Discover")
            }

            Tab("Search", systemImage: "magnifyingglass") {
                Color.clear.styledTabContent("Search")
            }
        }
    }
}

#Preview {
    TabViewExample()
}
