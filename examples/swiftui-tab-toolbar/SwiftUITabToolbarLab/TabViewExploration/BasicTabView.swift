import SwiftUI

/// Basic TabView with bottom navigation (iOS 26+)
/// This is the most common TabView pattern - a bottom tab bar with 3 tabs
/// Use this for: Main app navigation, primary user flows
/// Key features:
/// - Tab bar appears at bottom of screen
/// - Each tab has a label and SF Symbol icon
/// - Tapping a tab switches content and highlights the tab
/// - Automatic liquid glass effect on iOS 26+
struct BasicTabView: View {
    var body: some View {
        TabView {
            // First tab: Home
            // Uses SF Symbol "house" icon
            Tab("Home", systemImage: "house") {
                Color.clear.styledTabContent("Home")
            }

            // Second tab: Profile
            // Uses SF Symbol "person.circle" icon
            Tab("Profile", systemImage: "person.circle") {
                Color.clear.styledTabContent("Profile")
            }

            // Third tab: Settings
            // Uses SF Symbol "gear" icon
            Tab("Settings", systemImage: "gear") {
                Color.clear.styledTabContent("Settings")
            }
        }
        // No .tabViewStyle() needed - uses default bottom tab bar
    }
}

#Preview {
    BasicTabView()
}
