import SwiftUI

struct FavoritesScreen: View {
    @State private var favorites: [Article] = []

    var body: some View {
        VStack {
            Text("Favorites")
                .font(.largeTitle)
                .padding()

            if favorites.isEmpty {
                Text("No favorites yet")
                    .font(.headline)
                    .foregroundColor(.gray)
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(favorites) { article in
                            CardViewNew(article: article, favorites: $favorites)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            loadFavorites()
        }
    }

    // Load favorites from UserDefaults
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let savedFavorites = try? JSONDecoder().decode([Article].self, from: data) {
            favorites = savedFavorites
        }
    }
}
