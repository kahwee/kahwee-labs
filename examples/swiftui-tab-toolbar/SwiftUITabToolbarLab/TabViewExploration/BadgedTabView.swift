import SwiftUI

/// TabView with notification badges
/// Demonstrates how to show badge counts on tabs (like unread messages)
/// Use this for: Messaging apps, notification centers, unread counts
/// Key features:
/// - .badge() modifier adds a red bubble with a number
/// - Badge appears on the tab bar icon
/// - iOS handles positioning and styling automatically
/// - Commonly used for Messages, Mail, social apps
struct BadgedTabView: View {
    // State variables tracking counts for each tab
    @State private var messageCount = 3
    @State private var notificationCount = 7

    var body: some View {
        VStack {
            // Interactive controls to demonstrate dynamic badge updates
            HStack {
                Button("Add Message") {
                    // Increment message count - badge updates automatically
                    messageCount += 1
                }
                .buttonStyle(.bordered)

                Button("Clear Notifications") {
                    // Clear notifications - badge disappears when 0
                    notificationCount = 0
                }
                .buttonStyle(.bordered)
            }
            .padding()

            TabView {
                // Messages tab with badge
                Tab("Messages", systemImage: "message") {
                    Color.clear.styledTabContent("Messages (\(messageCount))")
                }
                // THIS IS KEY: .badge(messageCount) shows red bubble with count
                .badge(messageCount)

                // Notifications tab with conditional badge
                Tab("Notifications", systemImage: "bell") {
                    Color.clear.styledTabContent("Notifications (\(notificationCount))")
                }
                // Badge only shows when count > 0
                // iOS automatically hides badge when value is 0
                .badge(notificationCount > 0 ? notificationCount : 0)

                // Profile tab with no badge
                Tab("Profile", systemImage: "person") {
                    Color.clear.styledTabContent("Profile")
                }
            }
        }
    }
}

#Preview {
    BadgedTabView()
}
