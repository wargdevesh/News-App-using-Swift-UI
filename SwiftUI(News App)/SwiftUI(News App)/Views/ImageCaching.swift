//
//  ImageCaching.swift
//  SwiftUI(News App)
//
//  Created by USER on 17/10/24.
//

import SwiftUI
import SwiftUI

// ImageCache to hold cached images
class ImageCache {
    static let shared = ImageCache()
    private init() {}
    
    private var cache = NSCache<NSString, UIImage>()
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

// ImageLoader class to load images asynchronously
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let urlString: String
    private let cache = ImageCache.shared
    
    init(urlString: String) {
        self.urlString = urlString
        loadImageFromURL()
    }
    
    fileprivate func loadImageFromURL() {
        // Check if image is already cached
        if let cachedImage = cache.getImage(forKey: urlString) {
            self.image = cachedImage
            return
        }
        
        // If not cached, download the image
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    // Cache the image
                    self?.cache.setImage(image, forKey: self?.urlString ?? "")
                    // Set the image to the published property
                    self?.image = image
                }
            }
        }.resume()
    }
}

// Custom view to display the image from a URL
struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    var placeholder: Image
    
    init(urlString: String, placeholder: Image = Image("no_image", bundle: nil)) {
        _loader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
        self.placeholder = placeholder
    }
    
    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            placeholder
                .resizable()
                .scaledToFit()
                .onAppear {
                    loader.loadImageFromURL()
                }
        }
    }
}

#Preview {
    AsyncImageView(urlString: "")
}
