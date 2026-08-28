import SwiftUI

/// A dedicated, functional search destination.
///
/// `Tab(role: .search)` identifies the destination to the system. The
/// `.searchable` modifier supplies the search field, while this view still owns
/// the query and filtering behavior.
struct SearchTabView: View {
  @State private var query = ""

  private let topics = [
    "SwiftUI",
    "UIKit",
    "Accessibility",
    "Animations",
    "Performance",
    "Testing",
    "Navigation",
    "Data Flow",
  ]

  var body: some View {
    TabView {
      Tab("Articles", systemImage: "newspaper") {
        Color.clear.styledTabContent("Articles")
      }

      Tab("About", systemImage: "info.circle") {
        Color.clear.styledTabContent("About")
      }

      Tab(role: .search) {
        NavigationStack {
          List(filteredTopics, id: \.self) { topic in
            Text(topic)
          }
          .navigationTitle("Search")
          .overlay {
            if filteredTopics.isEmpty {
              ContentUnavailableView.search(text: query)
            }
          }
        }
      }
    }
    .searchable(text: $query, prompt: "Search topics")
  }

  private var filteredTopics: [String] {
    guard !query.isEmpty else {
      return topics
    }

    return topics.filter { topic in
      topic.localizedCaseInsensitiveContains(query)
    }
  }
}

#Preview {
  SearchTabView()
}
