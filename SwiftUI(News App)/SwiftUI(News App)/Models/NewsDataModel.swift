

// MARK: - NewsData
import Foundation

// Model for the main response
struct NewsResponse: Codable{
    
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// Model for each article
struct Article: Identifiable,Codable{
    var id: String {
          return url
      }
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    var isFavorite: Bool = false 
    
    enum CodingKeys: String, CodingKey {
           case title
           case description
           case url
           case urlToImage
           case source
           case author
           case publishedAt
           case content
       }
    
   /* enum CodingKeys: String,CodingKey{
     case source = "source"
     case author = "author"
     case title = "title"
     case description = "description"
     case url = "url"
     case urlToImage = "urlToImage"
     case publishedAt = "publishedAt"
     case content = "content"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source = try? values.decodeIfPresent(Source.self, forKey: .source)
        author = try? values.decodeIfPresent(String.self, forKey: .author)
        title = try? values.decodeIfPresent(String.self, forKey: .title)
        description = try? values.decodeIfPresent(String.self, forKey: .description)
        url = try? values.decodeIfPresent(String.self, forKey: .url)
        urlToImage = try? values.decodeIfPresent(String.self, forKey: .urlToImage)
//        permissions = try values.decodeIfPresent([String].self, forKey: .permissions)
//        is_editable = try values.decodeIfPresent(Bool.self, forKey: .is_editable)
//        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
//        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
//        organization = try values.decodeIfPresent(Int.self, forKey: .organization)
//        created_by = try values.decodeIfPresent(Int.self, forKey: .created_by)
//        updated_by = try values.decodeIfPresent(String.self, forKey: .updated_by)
    }*/
}

// Model for the source of the article
struct Source: Codable {
    let id: String?
    let name: String
}
