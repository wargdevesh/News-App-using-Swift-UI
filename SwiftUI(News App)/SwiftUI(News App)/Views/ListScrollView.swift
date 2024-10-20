import SwiftUI
import WebKit

// Model representing a section with a header and items
struct SectionData: Identifiable {
    let id = UUID()           // Unique ID for each section
    let header: String        // Section header title
    let items: [ItemData]     // Items in the section
}

// Model representing the item with a name and URL
struct ItemData: Identifiable {
    let id = UUID()           // Unique ID for each item
    let name: String          // Item name
    let url: String           // URL for the web content
}

// Main ContentView
struct ContentView2: View {
    
    // Sample data: Array of SectionData
    let sections: [SectionData] = [
        SectionData(header: "Popular", items: [
            ItemData(name: "Item 1", url: "https://www.example.com"),
            ItemData(name: "Item 2", url: "https://www.example.com"),  ItemData(name: "Item 3", url: "https://www.example.com"),
            ItemData(name: "Item 4", url: "https://www.example.com")
        ]),
        SectionData(header: "Recent", items: [
            ItemData(name: "Item 1", url: "https://www.example.com"),
            ItemData(name: "Item 2", url: "https://www.example.com"),
            ItemData(name: "Item 3", url: "https://www.example.com"),
            ItemData(name: "Item 4", url: "https://www.example.com")
        ])
    ]
    
    @Binding  var isVerticalScrolling : Bool // State variable to toggle scrolling direction
    @Binding var categories:String
    @ObservedObject var  viewModel: HomeViewModel
    @State private var favorites: [Article] = []
    var onItemClick: (Article) -> Void

    var body: some View{
            VStack {
                // Toggle to switch between vertical and horizontal scrolling

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                    
                                if isVerticalScrolling {
                                    // Vertical scroll layout (LazyVStack)
                                 //   Text("\(viewModel.selectedCategories.count == 0 ? "Top Headlines" : "\(viewModel.selectedCategories.last ?? "Top") Headlines")").padding()
                                    LazyVStack(spacing: 16) {
                                      // if let articles = viewModel.articles{
                                      //  if let section = viewModel.articles
                                        ForEach(viewModel.articles.keys.sorted(), id: \.self) { section in
                                                            // Section Header
                                            HStack {
                                                Text(section == "all" ? "Top Headlines" : section)
                                                    .font(.system(size: 20,weight: .bold))
                                                    .padding(.horizontal)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .padding(.trailing)
                                            }.padding()
                                            ForEach(viewModel.articles[section] ?? []) { item in
                                                NavigationLink(destination: NewsDetail(item: item)) {
                                                    CardViewVertical(article: item,favorites: $favorites)
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                } else {
                                    // Horizontal scroll layout (LazyHStack)
                                    ScrollView(.vertical, showsIndicators: false) { // Vertical scroll for sections
                                            LazyVStack(alignment: .leading, spacing: 20) { // Stack sections vertically
                                                ForEach(viewModel.articles.keys.sorted(), id: \.self) { section in
                                                    VStack(alignment: .leading, spacing: 10) {
                                                        // Section Header with Text and Arrow
                                                        HStack {
                                                            Text(section == "all" ? "Top Headlines" : section)
                                                                .font(.system(size: 20,weight: .bold))
                                                                .padding(.horizontal)
                                                            Spacer()
                                                            Image(systemName: "chevron.right")
                                                                .padding(.trailing)
                                                        }
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .background(Color.gray.opacity(0.2))
                                                        .padding(.horizontal)

                                                        // Horizontal Scroll for Cards in each section
                                                        ScrollView(.horizontal, showsIndicators: false) {
                                                            LazyHStack(spacing: 16) {
                                                                ForEach(viewModel.articles[section] ?? []) { item in
                                                                    CardView2(article: item, favorites: $favorites)
                                                                        .onTapGesture {
                                                                            onItemClick(item)
                                                                        }
                                                                        .padding(.horizontal)
                                                                }
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.top)
                                        }
                                  /*  ScrollView(.horizontal, showsIndicators: false) {
                                        LazyHStack(spacing: 16) {
                                            //if let articles = viewModel.articles{
                                            ForEach(viewModel.articles.keys.sorted(), id: \.self) { section in
                                                VStack(alignment: .leading, spacing: 10) {
                                                                // Section Header
                                                                Text(section)
                                                                    .font(.headline)
                                                                    .padding()
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                    .background(Color.gray.opacity(0.2))

                                                                // Horizontal scrolling for cards within each section
                                                                ScrollView(.horizontal, showsIndicators: false) {
                                                                    LazyHStack(spacing: 16) {
                                                                        ForEach(viewModel.articles[section] ?? [], id: \.self) { item in
                                                                            CardView2(article: item, favorites: $favorites)
                                                                                .onTapGesture {
                                                                                    onItemClick(item)
                                                                                }
                                                                                .padding(.horizontal)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            .padding(.bottom, 20)
                                            }
                                                    // }
                                                
                                            //}
                                        }
                                        .padding()
                                    }*/
                                }
                            //}
                        //}
                    }
                    .padding(.vertical)
                }
            }
            .navigationBarHidden(true) // Optional: Hide default navigation bar
       
    }
}

// CardView representing each item in the section
struct CardView2: View {
    @State var article: Article
    @Binding var favorites: [Article] // Item data passed into each card
    var body: some View {
        VStack(alignment:.leading) {
            // Star Icon in Each Row
            ZStack(alignment:.topLeading){
                HStack{
                    Spacer()
                    AsyncImageView(urlString: article.urlToImage ?? "").scaledToFit()//.frame(width: 100,height: 100,alignment: .center)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    Spacer()
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                Button(action: {
                                  article.isFavorite.toggle()  // Toggle favorite status
                                  if article.isFavorite {
                                      addToFavorites(article)
                                  } else {
                                      removeFromFavorites(article)
                                  }
                              }) {
                                  Image(systemName: article.isFavorite ? "star.fill" : "star")
                                      .foregroundColor(article.isFavorite ? .red : .gray).scaledToFit()
                              }
                              .buttonStyle(PlainButtonStyle())
              //  Image(systemName: "star").foregroundStyle(.black)
               //     .frame(width: 44,height: 44)
                    //.padding(EdgeInsets(top: 0, leading: 2, bottom: 10, trailing: 20))
              //  Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
               // }).frame(width: 44,height: 44)
                    //.padding(EdgeInsets(top: 0, leading: 2, bottom: 10, trailing: 20))
    
            }
          
            Spacer()
            // Heading and Lines
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Color(.black).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).frame(width: .infinity,height: 2)
                }
                Text(article.title)
                    .font(.system(size: 15,weight: .bold, design: .default)).foregroundStyle(.black).padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)).lineLimit(1)
                Text(article.description ??  "Description not available at the moment").font(.system(size: 12,weight: .regular, design: .default)).foregroundStyle(.black).padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)).lineLimit(3)
               /* Rectangle()
                    .fill(Color.black)
                    .frame(height: 1)
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 1)*/
            }
        }.frame(width: 120,height: 220) .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
        
    }
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

struct CardViewVertical: View {
    @State var article: Article
    @Binding var favorites: [Article]  // Item data passed into each card
    
    var body: some View {
        HStack {
            // Star Icon in Each Row
            ZStack(alignment:.topLeading){
                HStack{
                    Spacer()
                    AsyncImageView(urlString: article.urlToImage ?? "").scaledToFit()//.frame(width: 100,height: 100,alignment: .center)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    Spacer()
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                Button(action: {
                                  article.isFavorite.toggle()  // Toggle favorite status
                                  if article.isFavorite {
                                      addToFavorites(article)
                                  } else {
                                      removeFromFavorites(article)
                                  }
                              }) {
                                  Image(systemName: article.isFavorite ? "star.fill" : "star")
                                      .foregroundColor(article.isFavorite ? .red : .black).scaledToFit()
                                      //.frame(width: 54,height: 54)
                              }
                              .buttonStyle(PlainButtonStyle())
               // Spacer()
    
            }.frame(width: 120,height: 140) .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            
            // Heading and Lines
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title).font(.system(size: 15,weight: .bold, design: .default)).foregroundStyle(.black).padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)).lineLimit(1)
                
                Text(article.description ?? "Description not available at the moment").font(.system(size: 12,weight: .regular, design: .default)).foregroundStyle(.black).padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)).lineLimit(2)
                    
            
            }
            .padding()
        }.background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
        
      
    }
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


// NewsDetail View: This will display detailed information about the item
struct NewsDetail: View {
    let item: Article  // Pass item with name and URL to the detail screen
    
    var body: some View {
        VStack {
            Text("News Detail")
                .font(.largeTitle)
                .bold()
                .padding()
            
            // Display WebView with the item's URL
            WebView(urlString: item.url)
                .frame(maxWidth: .infinity, maxHeight: .infinity)  // Full-screen web content
            
            Spacer()
        }
        .navigationBarTitle(item.title, displayMode: .inline)  // Show the item name as title
    }
}

// WebView to display web content using WKWebView
struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

/*struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2(isVerticalScrolling: .constant(true))
    }
}
*/


//#Preview {
//    ContentView2(isVerticalScrolling:.constant(true), onItemClick: .constant((ItemData) -> Void))
//}
