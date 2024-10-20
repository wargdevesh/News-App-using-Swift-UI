import SwiftUI

struct TestView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Top navigation bar with back button and menu icon
                HStack {
                    Button(action: {
                        // Handle back button action
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                    }
                    Spacer()
                    Text("Business")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button(action: {
                        // Handle menu button action
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                    }
                }
                .padding()
                
                Divider()
                
                // Scrollable grid of cards
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0..<9) { _ in
                            CardView()
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// CardView representing each individual card
struct CardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Spacer()
            }
            .padding(.top)
            
            Text("Heading")
                .font(.headline)
                .bold()
            
            HStack {
                Image(systemName: "plus.square")
                Spacer()
            }
            
            Spacer()
            
            // Placeholder for text or description
            Text("Description goes here")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(height: 150)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


#Preview {
    TestView()
}
