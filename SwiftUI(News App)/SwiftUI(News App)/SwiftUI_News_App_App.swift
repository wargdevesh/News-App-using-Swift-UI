//
//  SwiftUI_News_App_App.swift
//  SwiftUI(News App)
//
//  Created by USER on 16/10/24.
//

import SwiftUI

@main
struct SwiftUI_News_App_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
