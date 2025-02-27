import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Example: Navigate to UserProfileView with a sample UserProfile

                NavigationLink(destination: UserProfileView()) {
                    Text("Go to User Profile")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                // Example: Navigate to PostView with a sample Post
                let samplePost = Post(id: UUID(), authorId: UUID(), content: "This is a post", likes: 10, imageURL: nil)
                
                NavigationLink(destination: PostView(post: samplePost)) {
                    Text("Go to Post View")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Memory Management App")
        }
    }
}
