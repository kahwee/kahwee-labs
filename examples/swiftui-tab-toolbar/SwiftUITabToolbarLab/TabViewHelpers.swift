import SwiftUI

/// Shared helpers for TabView and Toolbar examples
/// Provides consistent styling and demo data across all demonstrations
/// This extension is applied to all Views, making these helpers globally available
extension View {
    /// Computed property that returns a rainbow gradient background
    /// - `some View`: Returns a type conforming to View (Swift infers the exact type)
    /// - `.ignoresSafeArea()`: Extends gradient behind system UI (notch, home indicator)
    /// - Colors: Red → Orange → Yellow → Green → Blue → Purple
    /// - Direction: Diagonal from top-leading to bottom-trailing
    var rainbowGradient: some View {
        LinearGradient(
            colors: [.red, .orange, .yellow, .green, .blue, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    /// Helper function that creates consistent tab content with styled text
    /// Eliminates code duplication across all TabView examples
    /// - Parameter text: The text to display in the tab
    /// - Returns: A styled view with:
    ///   - Large bold text (40pt)
    ///   - Positioned at bottom of screen
    ///   - 100pt padding from bottom edge
    ///   - Rainbow gradient background
    func styledTabContent(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 40, weight: .bold))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 100)
            .background(rainbowGradient)
    }
}

/// Demo data generator for toolbar examples
/// Provides realistic placeholder data for lists and demos
struct DemoData {
    /// Popular first names for generating demo people
    static let firstNames = [
        "Emma", "Liam", "Olivia", "Noah", "Ava", "Ethan", "Sophia", "Mason",
        "Isabella", "William", "Mia", "James", "Charlotte", "Benjamin", "Amelia"
    ]

    /// Popular last names for generating demo people
    static let lastNames = [
        "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller",
        "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez",
        "Wilson", "Anderson"
    ]

    /// Generates a list of people with combined first and last names
    /// - Parameter count: Number of people to generate (default: 50)
    /// - Returns: Array of full names
    static func generatePeople(count: Int = 50) -> [String] {
        (0..<count).map { index in
            let firstName = firstNames[index % firstNames.count]
            let lastName = lastNames[index % lastNames.count]
            return "\(firstName) \(lastName)"
        }
    }
}
