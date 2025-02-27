import SwiftUI

struct PostView: View {
    let post: Post
    let profileManager: ProfileManager
    
    // State to track if the profile has loaded
    @State private var authorUsername: String? = nil
    
    var body: some View {
        HStack {
            // Image (either from post or default icon)
            if let imageURL = post.imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "photo") // Default icon if no image URL
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.trailing, 10)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                // Display the author's username
                if let username = authorUsername {
                    Text(username)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                // Like count
                Text("\(post.likes) likes")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Post content
                Text(post.content)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(nil)
            }
            .padding(.vertical, 10)
            
            Spacer() // Space between content and right side
        }
        .padding()
        .onAppear {
            // Fetch the profile of the post's author when the view appears
            loadAuthorProfile()
        }
    }
    
    // Function to load the author's profile based on post's authorId
    private func loadAuthorProfile() {
        guard let profile = profileManager.getProfile(for: post.authorId) else {
            // Profile not found, load it
            profileManager.loadProfile(id: post.authorId, username: "loading...", bio: "loading bio", followers: 0) { result in
                switch result {
                case .success(let userProfile):
                    self.authorUsername = userProfile.username
                case .failure(let error):
                    print("Failed to load profile: \(error)")
                }
            }
            return
        }
        
        // If profile already loaded, use it
        self.authorUsername = profile.username
    }
}
