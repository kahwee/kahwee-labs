import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("TabView") {
                    NavigationLink("Basic tabs") { BasicTabView() }
                    NavigationLink("Four-tab example") { TabViewExample() }
                    NavigationLink("Search role") { SearchTabView() }
                    NavigationLink("Badges") { BadgedTabView() }
                    NavigationLink("Programmatic selection") { SelectableTabView() }
                    NavigationLink("Sidebar adaptation") { SidebarAdaptableTabView() }
                    NavigationLink("Page style") { PageTabView() }
                    NavigationLink("Custom paging") { CustomPageView() }
                }

                Section("Toolbar") {
                    NavigationLink("Basic toolbar") { BasicToolbarDemo() }
                    NavigationLink("Four corners") { FourCornersDemo() }
                    NavigationLink("Kitchen sink") { ToolbarKitchenSink() }
                    NavigationLink("Ten trailing items") { TenItemsTopTrailing() }
                    NavigationLink("Search") { ToolbarSearchDemo() }
                    NavigationLink("Principal placement") { PrincipalPlacementDemo() }
                    NavigationLink("Modal toolbar") { ModalToolbarDemo() }
                    NavigationLink("Visibility") { ToolbarVisibilityDemo() }
                    NavigationLink("Showcase") { ToolbarShowcase() }
                }
            }
            .navigationTitle("SwiftUI Controls Lab")
        }
    }
}

#Preview {
    ContentView()
}
