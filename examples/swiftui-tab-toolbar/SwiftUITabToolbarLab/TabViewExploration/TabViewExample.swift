import SwiftUI

/// Basic TabView example using the Tab API introduced in iOS 18.
/// Demonstrates four tabs with a rainbow gradient background
struct TabViewExample: View {
  /// Main view body containing TabView with four tabs including Search
  /// The Tab API provides a type-safe, declarative structure.
  /// TabView automatically handles:
  /// - Selection while this view hierarchy remains alive
  /// - Smooth animations between tabs
  /// - Accessible system tab controls (destination content remains the app's responsibility)
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
