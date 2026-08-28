import SwiftUI

/// TabView with programmatic selection control
/// Demonstrates how to control tab selection from code (not just user taps)
/// Use this for: Deep linking, guided flows, conditional navigation
/// Key features:
/// - Bind to a @State variable to control which tab is shown
/// - Change the variable to programmatically switch tabs
/// - Listen to onChange to react when tab selection changes
/// - Useful for routing, analytics, or multi-step processes
struct SelectableTabView: View {
    // State variable tracking which tab is selected
    // Starts at tab 1
    @State private var selectedTab = 1

    var body: some View {
        VStack {
            // Control buttons to programmatically switch tabs
            // These buttons change the selectedTab value
            HStack {
                ForEach(1...3, id: \.self) { index in
                    Button("Go to Tab \(index)") {
                        // THIS IS KEY: Changing selectedTab switches the active tab
                        selectedTab = index
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()

            // TabView with selection binding
            // THIS IS KEY: TabView(selection: $selectedTab) creates two-way binding
            // - When user taps tab, selectedTab updates
            // - When selectedTab changes in code, TabView switches tabs
            TabView(selection: $selectedTab) {
                // Each Tab needs a value parameter matching the selection type (Int)
                Tab("First", systemImage: "1.circle", value: 1) {
                    Color.clear.styledTabContent("First")
                }

                Tab("Second", systemImage: "2.circle", value: 2) {
                    Color.clear.styledTabContent("Second")
                }

                Tab("Third", systemImage: "3.circle", value: 3) {
                    Color.clear.styledTabContent("Third")
                }
            }
            // Listen for tab changes (useful for analytics, logging)
            .onChange(of: selectedTab) { _, newValue in
                print("Selected tab: \(newValue)")
            }
        }
    }
}

#Preview {
    SelectableTabView()
}
