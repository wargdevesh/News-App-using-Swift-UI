import SwiftUI

struct CardViewNew: View {
    @State var article: Article
    @Binding var favorites: [Article]  // Bind to the favorites list in view model
    
    var body: some View {
        VStack(alignment: .leading) {
            // Show article image, title, and description
            Text(article.title)
                .font(.headline)
            
            if let description = article.description {
                Text(description)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.gray)
            }
            
            HStack {
                Spacer()
                
                // Favorite Button
                Button(action: {
                    // Toggle favorite status
                        removeFromFavorites(article)
                    
                }) {
                    Image(systemName: article.isFavorite ? "trash" : "trash")
                        .foregroundColor(article.isFavorite ? .red : .gray)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    // Add to favorites
    private func addToFavorites(_ article: Article) {
        favorites.append(article)
        saveFavorites()
    }
    
    // Remove from favorites
    private func removeFromFavorites(_ article: Article) {
        favorites.removeAll { $0.id == article.id }
        saveFavorites()
    }
    
    // Save favorites to UserDefaults
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: "favorites")
        }
    }
}
