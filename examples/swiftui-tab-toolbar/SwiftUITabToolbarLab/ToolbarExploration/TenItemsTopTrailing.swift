import SwiftUI

/// Toolbar with Many Items (Overflow Demo)
/// Demonstrates overflow behavior with 10+ items in one placement
/// Use this for: Apps with many secondary actions, rich editing interfaces
/// Key features:
/// - ToolbarItemGroup groups multiple items in one placement
/// - System automatically overflows to "More" menu on smaller screens
/// - Works best on iPad and macOS where space allows
/// - Maintains accessibility with proper labels
/// - Shows state management with left toolbar icon
/// - Uses SwiftUI alerts for user feedback (the Apple way)
struct TenItemsTopTrailing: View {
    @State private var isStarred = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    // Different icons for variety
    private let trailingIcons = [
        "pencil", "trash", "square.and.arrow.up", "doc.on.doc",
        "folder", "tag", "link", "clock", "bell", "flag"
    ]

    private let people = DemoData.generatePeople()

    var body: some View {
        NavigationStack {
            List(people, id: \.self) { person in
                Text(person)
            }
            .navigationTitle("Lots of Actions")
            // THIS IS KEY: SwiftUI alert for feedback
            // This is the native Apple way to show brief messages
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK") { }
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
