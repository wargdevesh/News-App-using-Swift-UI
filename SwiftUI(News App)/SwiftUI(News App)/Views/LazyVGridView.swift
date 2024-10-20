//
//  LazyVGridView.swift
//  SwiftUI(News App)
//
//  Created by USER on 16/10/24.
//

import SwiftUI

import SwiftUI

struct LazyVGridView: View {
    
    // Define the grid layout
    let columns = [
        GridItem(.flexible()),  // This creates a flexible column
     //   GridItem(.flexible()),  // Two flexible columns that share space equally
        //GridItem(.flexible())   // Three items per row
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<30) { index in
                    HStack {
                        // Star Icon in Each Row
                        Image(systemName: "star")
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        
                        // Heading and Lines
                        VStack(alignment: .leading, spacing: 8) {
                            Text("HEADING")
                                .font(.headline)
                                .bold()
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 1)
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 1)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }
                }
            }
            .padding()
        }
    }
}

struct LazyVGridComponent_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGridView()
    }
}


#Preview {
    LazyVGridView()
}
