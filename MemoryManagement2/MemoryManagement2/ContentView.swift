import SwiftUI

struct ContentView: View {
    let profileManager = ProfileManager(delegate: nil)
    let username = "Nurkhan"

    let samplePosts: [Post] = [
            Post(id: UUID(), authorId: UUID(), content: "Первый пост!", likes: 20, imageURL: URL(string: "https://i.pinimg.com/736x/dd/82/b9/dd82b9083856d718cadfd8ebdaa8d4c7.jpg")),
            Post(id: UUID(), authorId: UUID(), content: "Второй пост с картинкой!", likes: 35, imageURL: URL(string: "https://i.pinimg.com/736x/e8/8c/0f/e88c0fc44c386300eb6fad8324c7baf2.jpg")),
            Post(id: UUID(), authorId: UUID(), content: "Погода за окном радует!", likes: 15, imageURL: URL(string: "https://i.pinimg.com/736x/75/c1/88/75c18814ca7af652e7b3856c1fb25591.jpg")),
            Post(id: UUID(), authorId: UUID(), content: "New State. New life", likes: 216, imageURL: URL(string: "https://images.ctfassets.net/1aemqu6a6t65/7agXa8CmAoqIixMXCSiBFP/adc6f8de5aae334137838ebb4801140b/brooklyn-bridge-photo-julienne-schaer-nyc-and-company-003-2?w=1200&h=800&q=75")),
            Post(id: UUID(), authorId: UUID(), content: "Looking for something new", likes: 8, imageURL: URL(string: "https://i.pinimg.com/736x/6a/3d/ad/6a3dadc96e948c148186d19d5eb2fb3f.jpg")),
            Post(id: UUID(), authorId: UUID(), content: "Продаю машину. СРОЧНО!!!!", likes: 53, imageURL: URL(string: "https://i.pinimg.com/736x/c0/3d/17/c03d1719f789e26ee2b1650d047c3ac1.jpg")),
            Post(id: UUID(), authorId: UUID(), content: "Пополнение в семье. Посмотрите какой милашка", likes: 5423, imageURL: URL(string: "https://i.pinimg.com/736x/82/e2/8a/82e28ab029a0a250664dc96342d8832d.jpg")),

        ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                NavigationLink(destination: UserProfileView()) {
                    Text(username)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.leading)
                }
                
                Text("Feed")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.top, 5)
                
                FeedView(posts: samplePosts, profileManager: profileManager)
            }
            .navigationBarHidden(true) 
        }
    }
}
