import SwiftUI

/// Modal/Sheet Toolbar Demo
/// Demonstrates toolbar for modal presentations with Cancel/Done actions
/// Use this for: Edit forms, modal sheets, confirmation dialogs
/// Key features:
/// - .cancellationAction: Places Cancel button (left on iOS)
/// - .confirmationAction: Places Done/Save button (right on iOS)
/// - .destructiveAction: Places destructive action (e.g., Delete)
/// - Follows platform conventions automatically
struct ModalToolbarDemo: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear.styledTabContent("Modal Demo")

                Button("Show Modal") {
                    showSheet = true
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Modal Demo")
        }
        .sheet(isPresented: $showSheet) {
            // Modal content with toolbar
            NavigationStack {
                Color.clear.styledTabContent("Edit Content")
                    .navigationTitle("Edit")
                    .toolbar {
                        // THIS IS KEY: These placements follow iOS conventions
                        // .cancellationAction → Left side (Cancel)
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                dismiss()
                            }
                        }

                        // .confirmationAction → Right side (Done/Save)
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                dismiss()
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ModalToolbarDemo()
}
