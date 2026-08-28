import SwiftUI

/// Principal Placement Demo
/// Demonstrates .principal placement for custom navigation title views
/// Use this for: Two-line titles, custom branding, interactive titles
/// Key features:
/// - .principal replaces navigation title with custom view
/// - Used in Mail app (sender + subject), Messages (name + status)
/// - Must use .navigationBarTitleDisplayMode(.inline)
/// - Large titles (.large, .automatic) will ignore .principal placement
struct PrincipalPlacementDemo: View {
    var body: some View {
        NavigationStack {
            Color.clear.styledTabContent("Principal Demo")
                // IMPORTANT: Must use .inline for .principal to work
                // .large or .automatic will ignore your custom view
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // THIS IS KEY: .principal replaces the title with custom view
                    // Common use: Two-line titles (name + status)
                    // Like Messages app showing "John Doe" + "Online"
                    ToolbarItem(placement: .principal) {
                        VStack(spacing: 2) {
                            Text("John Doe")
                                .font(.headline)
                            Text("Online")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
        }
    }
}

#Preview {
    PrincipalPlacementDemo()
}
