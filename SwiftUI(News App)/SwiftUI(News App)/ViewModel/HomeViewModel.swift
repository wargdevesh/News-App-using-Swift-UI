//
//  HomeViewModel.swift
//  TabBar&ChartsSwiftUi
//
//  Created by Devesh Pandey on 28/04/24.
//

import Foundation
import Combine


final class HomeViewModel : ObservableObject{
    @Published var mainData : NewsResponse? = nil
    @Published var filteredArticles: [Article]? = []
    @Published var isLoading  = false
    @Published var articles: [String:[Article]] = [:]// Published property to hold articles
    @Published var selectedItem: Article?
    @Published var availableCategories: [String] = ["Business", "Entertainment", "Health", "Science", "Sports", "Technology"]
    @Published var categorizedArticles: [String: [Article]] = [:]
    @Published var selectedCategories: [String] = []  // To track selected categories

    
    func fetchArticles(for category: String){
       self.isLoading = true
        ApiCaller.getData(category) {[self] result in
            self.isLoading = false
            switch result{
            case .success(let data):
                do{
                    DispatchQueue.main.async {
                        
                        self.mainData = data
                        if var sectionData = articles[category]{
                            articles[category] = nil
                        }
                        else{
                            articles[category] = data.articles
                        }
                    }
                    debugPrint("data from the server is \(data)")
                }
            case .failure(let error):
                do{
                    debugPrint("The error is \(error)")
                }
            }
           // self?.isLoading = false
        }
    }
     
    func toggleCategory(_ category: String) {
           if articles[category] != nil {
               removeArticles(for: category)  // Deselect and remove articles
           } else {
               fetchArticles(for: category)   // Fetch articles for the selected category
               selectedCategories.append(category)
           }
       }

       // Function to remove articles for a deselected category
       func removeArticles(for category: String) {
           categorizedArticles[category] = nil
           articles[category]  = nil
           if let index = selectedCategories.firstIndex(of: category) {
               selectedCategories.remove(at: index)  // Remove the category from selected list
           }
       }
}
