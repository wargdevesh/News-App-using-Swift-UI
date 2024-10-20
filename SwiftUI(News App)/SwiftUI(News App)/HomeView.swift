//  ContentView.swift
//  SwiftUI(News App)
//  Created by USER on 16/10/24.
//

import SwiftUI
import CoreData

struct Categories:Identifiable{
    var id:Int?
    var category:String?
    
}

struct HomeView: View {
    @State var searchParam:String = ""
    @State var isVerticalScrolling: Bool = true
    @State private var selectedItem: Article? = nil
    @StateObject var homeViewModel = HomeViewModel()
    @State var isDropDown: Bool = false
    @State var category:String = ""
    var categories:[Categories] = [Categories(id:0,category:"business" ),Categories(id:1,category:"entertainment"),Categories(id:2,category:"general"),Categories(id:3,category:"health" ),Categories(id:4,category:"all")]
    @StateObject private var networkMonitor = NetworkMonitor()  // Track network status
       @State private var showFavoritesOffline = false

    var body: some View {
        NavigationView {
            VStack {
                // Filter and Icons Row
                if !networkMonitor.isConnected {
                                  NavigationLink(
                                      destination: FavoritesScreen(),
                                     // isActive: $showFavoritesOffline,
                                      label: { EmptyView() }
                                  )
                              }
                VStack{
                    HStack {
                        // Filter Dropdown
                        HStack {
                            TextField("Buisness,Technology....",text: $searchParam).onSubmit {
                                // homeViewModel.getData(category: self.searchParam)
                            }
                            Image(systemName: isDropDown ? "chevron.up" : "chevron.down").onTapGesture {
                                isDropDown  = !isDropDown
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
                        
                        // Star Icon
                            NavigationLink(destination: FavoritesScreen()) {
                                Image(systemName: "star")
                                    .padding().frame(width: 44,height: 44)
                                           }
                                           .padding()
                          //  Image(systemName: "star")
                                .padding().frame(width: 44,height: 44)
                        
                        
                        // Grid Icon
                        Button(action: {
                            // Action for grid icon
                            isVerticalScrolling = !isVerticalScrolling
                        }) {
                            Image(systemName: isVerticalScrolling ? "square.grid.2x2" : "list.dash")
                                .padding().frame(width: 44,height: 44)
                            
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 10))
                    if isDropDown {
                        HStack {
                                          Text("Filter by Category:").font(.system(size: 15,weight: .bold, design: .default))
                                              .font(.headline)
                            Menu {
                                                ForEach(homeViewModel.availableCategories, id: \.self) { category in
                                                    Button(action: {
                                                        homeViewModel.toggleCategory(category)  // Toggle selection/deselection
                                                    }) {
                                                        HStack {
                                                            Text(category)
                                                            Spacer()
                                                            // Show checkmark if the category is selected
                                                            if homeViewModel.selectedCategories.contains(category) {
                                                                Image(systemName: "checkmark")
                                                                    .foregroundColor(.blue)
                                                            }
                                                        }
                                                    }
                                                }
                                            } label: {
                                                Text("Select Categories").font(.system(size: 12,weight: .bold, design: .default))
                                                    .padding()
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(8)
                                            }
                                      }
                    }
                }
                if(!networkMonitor.isConnected){
                    Text(" Not able to connect,Please check your network meanwhile you can visit your favourites").padding()
                }
                ContentView2(isVerticalScrolling: $isVerticalScrolling, categories: $category, viewModel: homeViewModel,onItemClick: { item in
                    self.selectedItem = item  // Set selected item on card click
                })
                
                if let selectedItem = selectedItem {
                    NavigationLink(
                                   destination: NewsDetail(item: selectedItem),
                                   isActive: .constant(true),
                                   label: { EmptyView() }
                               )
                   /* NavigationLink(
                        destination: NewsDetail(item: selectedItem),
                        isActive: .constant(true), // Automatically navigate
                        label: { EmptyView() }
                    )*/
                }
            }}.navigationBarTitle("First Screen", displayMode: .inline)
            .onAppear(perform: {
                homeViewModel.fetchArticles(for: "all")
                if !networkMonitor.isConnected {
                    showFavoritesOffline = true
                    
                }

                })
            // List of Cards
           
    }
        
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}





#Preview {
    HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
