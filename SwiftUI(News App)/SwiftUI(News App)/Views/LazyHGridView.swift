//
//  LazyHGridView.swift
//  SwiftUI(News App)
//
//  Created by USER on 16/10/24.
//

import SwiftUI

import SwiftUI

struct LazyHGridComponent: View {
    
    // Define the grid rows for LazyHGrid
    let rows = [
        GridItem(.fixed(100)),  // First row
         // Second row
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 16) {
                Section(header: Text("Popular")
                    .font(.headline)) {
                        ForEach(0..<20) { index in
                            VStack(alignment:.leading) {
                                // Star Icon in Each Row
                                ZStack{ Image(systemName: "star")
                                        .padding().frame(width: 44,height: 44)
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    }).frame(width: 44,height: 44)
                                } .padding(EdgeInsets(top: 0, leading: 2, bottom: 10, trailing: 20))
                                
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
                                } .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 20))
                            }
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                            
                        }
                    }}
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 20))
                }
        }
    }

struct LazyHGridComponent_Previews: PreviewProvider {
    static var previews: some View {
        LazyHGridComponent()
    }
}

#Preview {
    LazyHGridComponent()
}
