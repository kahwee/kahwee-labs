import SwiftUI

/// Sidebar Adaptable TabView using APIs introduced in iOS 18.
/// The most advanced TabView - adapts layout based on screen size
/// Use this for: iPad apps, apps supporting multiple devices, complex navigation
/// Key features:
/// - iPhone (compact): Shows as bottom tab bar
/// - iPad (regular): Uses a top tab bar that can expand into a sidebar
/// - The example changes its destination structure for compact and regular widths
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
    // .sidebarAdaptable uses a bottom tab bar on iPhone and an adaptable
    // top tab bar/sidebar presentation on iPad.
    .tabViewStyle(.sidebarAdaptable)
  }
}

#Preview {
  SidebarAdaptableTabView()
}
