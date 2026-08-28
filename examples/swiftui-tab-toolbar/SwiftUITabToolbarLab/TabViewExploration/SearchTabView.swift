import SwiftUI

/// TabView with dedicated Search tab (iOS 26+)
/// Demonstrates Tab(role: .search) for system-integrated search
/// Use this for: Apps with prominent search functionality (like App Store, Music)
/// Key features:
/// - Tab(role: .search) gets special treatment from iOS
/// - Automatically uses magnifying glass icon
/// - May get special positioning or behavior in future iOS versions
/// - Follows Apple's search conventions
struct SearchTabView: View {
    var body: some View {
        TabView {
            // Regular tab: Issues
            Tab("Issues", systemImage: "newspaper") {
                Color.clear.styledTabContent("Issues")
            }

            // Regular tab: About
            Tab("About", systemImage: "info.circle") {
                Color.clear.styledTabContent("About")
            }

            // Special search tab using role
            // THIS IS KEY: Tab(role: .search) tells iOS this is a search tab
            // - No label or icon needed - iOS provides defaults
            // - Gets special system treatment and conventions
            Tab(role: .search) {
                Color.clear.styledTabContent("Search")
            }
        }
    }
}

#Preview {
    SearchTabView()
}
