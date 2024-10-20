//
//  ApiCaller.swift
//  TabBar&ChartsSwiftUi
//
//  Created by Devesh Pandey on 26/04/24.
//

import Foundation
enum ApiErrors : Error{
    case UrlError
    case NetworkError
    case ServerError
    case ConversionError
}

/*struct Categories:Identifiable{
    var id:Int?
    var category:String?
    
}*/
//var categories:[Categories] = [Categories(id:0,category:"business" ),Categories(id:1,category:"entertainment"),Categories(id:2,category:"general"),Categories(id:3,category:"health" )]

class ApiCaller : NSObject{
   // let apiKey = "eab66bc55ddf48228c29b8eb103c4912"
    
    public static func getData(_ category: String,_ completionHandler: @escaping(_ result : Result<NewsResponse,ApiErrors>) -> Void){
        
        
        let urlString = "https://newsapi.org/v2/top-headlines"
        var urlComponents = URLComponents(string: urlString)
       // let categoriesQuery = category.isEmpty ? nil : category.joined(separator: ",")
              
              // Add query parameters
        urlComponents?.queryItems = [
                 // URLQueryItem(name: "category", value: category),            // Hardcoded country
           // URLQueryItem(name: "sources", value:"bbc-news"),
            URLQueryItem(name: "country", value:"us"),
                  URLQueryItem(name: "apiKey", value:"eab66bc55ddf48228c29b8eb103c4912"),           // API key
            URLQueryItem(name: "category", value:  category == "all" ? nil : category)
                 // URLQueryItem(name: "category", value: category.lowercased() != "all" ? category.lowercased() : nil)  // Category, excluding "All"
              ]
              
              // Ensure the final URL is valid
        guard let url = urlComponents?.url else {
                  print("Invalid URL")
            completionHandler(.failure(.UrlError))
                  return
              }
        print("The url for the api call is \(url)")
        
     /*   guard let url = URL(string: urlString) else{
            debugPrint("URl Error is there")
            completionHandler(.failure(.UrlError))
            return
        }*/
        var urlRequest = URLRequest(url: url)
       // urlRequest.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")
        
        urlRequest.httpMethod = "get"
        URLSession.shared.dataTask(with: urlRequest) { data, networkResponse, error in
            if error == nil , let data = data{
                
                do{
                    let JSONString = String(data: data, encoding: .utf8)
                    let resultData = try JSONDecoder().decode(NewsResponse.self, from: data)
                    completionHandler(.success(resultData))
                    print("Result is \(resultData)")
                }catch{
                    completionHandler(.failure(.ConversionError))
                    
                    debugPrint("Error in the decoding is \(error)")
                }
            }
            else{
                debugPrint("Error came in calling api with status code \(String(describing: networkResponse))")
                completionHandler(.failure(.ServerError))
            }
        }.resume()
       
        
    }
}
