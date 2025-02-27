import SwiftUI

struct PostView: View {
    let post: Post
    let profileManager: ProfileManager
    
    // Используем ImageLoader для загрузки изображения
    @StateObject private var imageLoader = ImageLoader()
    @State private var authorUsername: String? = nil
    
    var body: some View {
        HStack {
            // Загружаем изображение через ImageLoader
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Rectangle()) // Делаем квадрат
                    .padding(.trailing, 10)
            } else {
                Image(systemName: "photo") // Заглушка, если нет изображения
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Rectangle())
                    .padding(.trailing, 10)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                // Имя автора
                if let username = authorUsername {
                    Text(username)
                        .font(.headline)
                        .foregroundColor(.primary)
                } else {
                    Text("Loading...") // Пока загружается имя
                        .font(.headline)
                        .foregroundColor(.gray)
                }

                // Лайки
                Text("\(post.likes) likes")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                // Текст поста
                Text(post.content)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(nil)
            }
            .padding(.vertical, 10)

            Spacer()
        }
        .padding()
        .onAppear {
            // Загружаем изображение
            if let imageURL = post.imageURL {
                imageLoader.loadImage(url: imageURL)
            }
            
            // Загружаем профиль автора
            loadAuthorProfile()
        }
    }
    
    // Функция загрузки профиля автора
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
