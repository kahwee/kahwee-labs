import SwiftUI

/// Sidebar Adaptable TabView (iOS 26+)
/// The most advanced TabView - adapts layout based on screen size
/// Use this for: iPad apps, apps supporting multiple devices, complex navigation
/// Key features:
/// - iPhone (compact): Shows as bottom tab bar
/// - iPad (regular): Shows as sidebar with sections
/// - Automatically adapts layout without extra code
/// - Supports TabSection for grouped navigation
/// - Apple's recommended approach for scalable apps
struct SidebarAdaptableTabView: View {
    // Read horizontal size class from environment
    // .compact = iPhone, narrow split screen
    // .regular = iPad, wide split screen
    @Environment(\.horizontalSizeClass) var horizontalSize

    var body: some View {
        TabView {
            // Main tab appears on all devices
            Tab("Main", systemImage: "house") {
                Color.clear.styledTabContent("Main")
            }

            // Conditional layout based on screen size
            if horizontalSize == .regular {
                // LARGER SCREENS (iPad): Show grouped sections in sidebar
                // THIS IS KEY: TabSection creates collapsible groups in sidebar
                TabSection("Content") {
                    Tab("Articles", systemImage: "doc.text") {
                        Color.clear.styledTabContent("Articles")
                    }

                    Tab("Videos", systemImage: "video") {
                        Color.clear.styledTabContent("Videos")
                    }

                    Tab("Podcasts", systemImage: "mic") {
                        Color.clear.styledTabContent("Podcasts")
                    }
                }

                TabSection("Tools") {
                    Tab("Calculator", systemImage: "function") {
                        Color.clear.styledTabContent("Calculator")
                    }

                    Tab("Notes", systemImage: "note.text") {
                        Color.clear.styledTabContent("Notes")
                    }
                }
            } else {
                // SMALLER SCREENS (iPhone): Show simplified tabs
                // Combine multiple related items into overview tabs
                Tab("Content", systemImage: "doc.text") {
                    Color.clear.styledTabContent("Content")
                }

                Tab("Tools", systemImage: "wrench.and.screwdriver") {
                    Color.clear.styledTabContent("Tools")
                }
            }

            // Search tab appears on all devices
            Tab(role: .search) {
                Color.clear.styledTabContent("Search")
            }
        }
        // THIS IS KEY: .sidebarAdaptable enables automatic layout switching
        // - Compact: Bottom tab bar (traditional iOS)
        // - Regular: Left sidebar (like Files app on iPad)
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    SidebarAdaptableTabView()
}
