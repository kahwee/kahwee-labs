import SwiftUI

/// Four Corners Toolbar Demo
/// Demonstrates toolbar placement in all four corners of the screen
/// Use this for: File browsers, editing apps, photo apps
/// Key features:
/// - .topBarLeading: Top-left corner (menu/navigation)
/// - .topBarTrailing: Top-right corner (primary actions)
/// - .bottomBar: Bottom toolbar actions (left and right)
/// - System automatically balances bottom bar layout
struct FourCornersDemo: View {
  private let people = DemoData.generatePeople()

  var body: some View {
    NavigationStack {
      List(people, id: \.self) { person in
        Text(person)
      }
      .navigationTitle("Four Corners")
      .toolbar {
        // Top-left corner
        // Common for: Menu, back navigation, sidebar toggle
        ToolbarItem(placement: .topBarLeading) {
          Button {
            // Menu action
          } label: {
            Image(systemName: "line.3.horizontal")
          }
        }

        // Top-right corner
        // Common for: Add, edit, share, primary actions
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            // Add action
          } label: {
            Image(systemName: "plus")
          }
        }

        // Bottom bar left side
        ToolbarItem(placement: .bottomBar) {
          Button {
            // Back action
          } label: {
            Label("Back", systemImage: "chevron.backward")
          }
        }

        // iOS 26's toolbar-specific spacer expresses the grouping intent.
        ToolbarSpacer(.flexible, placement: .bottomBar)

        // Bottom bar right side
        ToolbarItem(placement: .bottomBar) {
          Button {
            // Next action
          } label: {
            Label("Next", systemImage: "chevron.forward")
          }
        }
      }
    }
  }
}

#Preview {
  FourCornersDemo()
}
