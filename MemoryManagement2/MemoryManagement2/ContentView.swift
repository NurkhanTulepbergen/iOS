import SwiftUI

struct ContentView: View {
    let profileManager = ProfileManager(delegate: nil)
    let username = "Nurkhan" // Имя пользователя (можно сделать динамическим)

    // Массив постов
    let samplePosts: [Post] = [
            Post(id: UUID(), authorId: UUID(), content: "Первый пост!", likes: 20, imageURL: URL(string: "https://via.placeholder.com/300")), // Указываем прямую ссылку на изображение
            Post(id: UUID(), authorId: UUID(), content: "Второй пост с картинкой!", likes: 35, imageURL: URL(string: "https://via.placeholder.com/150")),
            Post(id: UUID(), authorId: UUID(), content: "Еще один текстовый пост", likes: 15, imageURL: nil)
        ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Имя пользователя сверху слева
                NavigationLink(destination: UserProfileView()) {
                    Text(username)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.leading)
                }
                
                // Заголовок "Лента" под именем
                Text("Feed")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.top, 5)
                
                // Лента постов
                FeedView(posts: samplePosts, profileManager: profileManager)
            }
            .navigationBarHidden(true) // Скрываем стандартный navigation title
        }
    }
}
