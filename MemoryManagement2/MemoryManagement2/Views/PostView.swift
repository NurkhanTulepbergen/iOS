import SwiftUI

struct PostView: View {
    let post: Post
    let profileManager: ProfileManager
    
    @StateObject private var imageLoader = ImageLoader()
    @State private var authorUsername: String? = nil
    
    var body: some View {
        HStack(spacing: 8) {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .clipShape(Rectangle())
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .clipShape(Rectangle())
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let username = authorUsername {
                    Text(username)
                        .font(.headline)
                        .foregroundColor(.primary)
                } else {
                    Text("Loading...")
                        .font(.headline)
                        .foregroundColor(.gray)
                }

                Text("\(post.likes) likes")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(post.content)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(nil)
            }

            Spacer()
        }
        .padding(.vertical, 4)
        .onAppear {
            if let imageURL = post.imageURL {
                imageLoader.loadImage(url: imageURL)
            }
            loadAuthorProfile()
        }
    }
    
    private func loadAuthorProfile() {
        guard let profile = profileManager.getProfile(for: post.authorId) else {
            profileManager.loadProfile(id: post.authorId, username: "loading...", bio: "loading bio", followers: 0) { result in
                switch result {
                case .success(let userProfile):
                    self.authorUsername = userProfile.username
                case .failure(let error):
                    print("Ошибка загрузки профиля: \(error)")
                }
            }
            return
        }
        self.authorUsername = profile.username
    }
}
