import SwiftUI

/// Page TabView with custom indicators AND bottom tab bar
/// Demonstrates hybrid: page-style scrolling + bottom navigation
/// Use this for: Apps with both pages (stories) and main navigation
/// Key features:
/// - Page dots visible for horizontal scrolling
/// - Bottom tab bar for main app navigation
/// - Combines two navigation patterns
/// - Useful for apps like Instagram (stories + main tabs)
struct CustomPageView: View {
    var body: some View {
        // Outer TabView: Bottom tab bar navigation
        TabView {
            // First tab: Pages with scrolling
            Tab("Stories", systemImage: "book.pages") {
                // Inner TabView: Horizontal page scrolling
                TabView {
                    // Generate 5 pages showing steps
                    ForEach(1...5, id: \.self) { index in
                        VStack {
                            // Star icon for each step
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.yellow)

                            // Step number text
                            Text("Step \(index)")
                                .font(.title2)
                                .padding()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue.opacity(0.1))
                    }
                }
                // THIS IS KEY: .page style makes it horizontal scrolling
                // Options: .always (always visible), .automatic (show on scroll), .never (hidden)
                .tabViewStyle(.page(indexDisplayMode: .always))
                // Interactive background shows dots more prominently
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            }

            // Second tab: Regular content
            Tab("Feed", systemImage: "newspaper") {
                Color.clear.styledTabContent("Feed")
            }

            // Third tab: Regular content
            Tab("Profile", systemImage: "person.circle") {
                Color.clear.styledTabContent("Profile")
            }
        }
        // No style modifier = default bottom tab bar
    }
}

#Preview {
    CustomPageView()
}
