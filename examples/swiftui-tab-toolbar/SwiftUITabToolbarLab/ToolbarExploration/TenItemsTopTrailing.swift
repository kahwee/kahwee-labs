import SwiftUI

/// Toolbar with Many Items (Overflow Demo)
/// Demonstrates overflow behavior with 10+ items in one placement
/// Use this for: Apps with many secondary actions, rich editing interfaces
/// Key features:
/// - ToolbarItemGroup groups multiple items in one placement
/// - The system may overflow items when the available toolbar space is exhausted
/// - The exact visible count is dynamic and should not be treated as an API guarantee
/// - Maintains accessibility with proper labels
/// - Shows state management with left toolbar icon
/// - Uses alerts only to make each otherwise-placeholder action observable
struct TenItemsTopTrailing: View {
  @State private var isStarred = false
  @State private var showAlert = false
  @State private var alertMessage = ""

  // Different icons for variety
  private let trailingIcons = [
    "pencil", "trash", "square.and.arrow.up", "doc.on.doc",
    "folder", "tag", "link", "clock", "bell", "flag",
  ]

  private let people = DemoData.generatePeople()

  var body: some View {
    NavigationStack {
      List(people, id: \.self) { person in
        Text(person)
      }
      .navigationTitle("Lots of Actions")
      // Alerts make the placeholder actions observable in this lab.
      .alert(alertMessage, isPresented: $showAlert) {
        Button("OK") {}
      }
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            isStarred.toggle()
            alertMessage = isStarred ? "Starred" : "Unstarred"
            showAlert = true
          } label: {
            Image(systemName: isStarred ? "star.fill" : "star")
              .foregroundColor(isStarred ? .yellow : .primary)
          }
        }

        ToolbarItemGroup(placement: .topBarTrailing) {
          ForEach(trailingIcons, id: \.self) { icon in
            Button {
              alertMessage = "\(icon.capitalized) clicked"
              showAlert = true
            } label: {
              Image(systemName: icon)
            }
          }
        }
      }
    }
  }
}

#Preview {
  TenItemsTopTrailing()
}
