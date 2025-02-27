import SwiftUI

struct ContentView: View {
    let profileManager = ProfileManager(delegate: nil)

    // Массив постов
    let samplePosts: [Post] = [
        Post(id: UUID(), authorId: UUID(), content: "Первый пост!", likes: 20, imageURL: URL(string: "https://via.placeholder.com/300")), // Указываем прямую ссылку на изображение
        Post(id: UUID(), authorId: UUID(), content: "Второй пост с картинкой!", likes: 35, imageURL: URL(string: "https://via.placeholder.com/150")),
        Post(id: UUID(), authorId: UUID(), content: "Еще один текстовый пост", likes: 15, imageURL: nil)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: FeedView(posts: samplePosts, profileManager: profileManager)) {
                    Text("Перейти в ленту")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Приложение")
        }
    }
}
