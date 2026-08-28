import SwiftUI

/// Page TabView with horizontal scrolling
/// This is NOT a bottom tab bar - it's for swipeable pages (like onboarding)
/// Use this for: Onboarding flows, photo galleries, tutorial sequences
/// Key features:
/// - Swipe horizontally to navigate between pages
/// - Page indicator dots appear at bottom
/// - No tab bar - just content that scrolls
/// - Common in Instagram stories, app walkthroughs
struct PageTabView: View {
    // Array of colors for each page
    let colors: [Color] = [.red, .green, .blue, .yellow]

    var body: some View {
        TabView {
            // Generate 4 pages using ForEach
            ForEach(0..<4) { index in
                // Each page is a colored rectangle
                RoundedRectangle(cornerRadius: 10)
                    .fill(colors[index])
                    .frame(width: 300, height: 200)
                    .overlay(
                        // Overlay text showing page number
                        Text("Page \(index + 1)")
                            .font(.title)
                            .foregroundColor(.white)
                    )
            }
        }
        // THIS IS KEY: .tabViewStyle(.page) makes it horizontal scrolling
        .tabViewStyle(.page)
        // Show page indicator dots with interactive background
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
    }
}

#Preview {
    PageTabView()
}
