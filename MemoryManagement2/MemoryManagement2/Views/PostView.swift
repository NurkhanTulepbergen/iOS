import SwiftUI

// Пример модели Post
struct PostView: View {
    let post: Post
    @State private var loadedImage: UIImage? = nil  // Состояние для хранения загруженного изображения
    @State private var errorMessage: String? = nil  // Состояние для хранения ошибки загрузки изображения
    @State private var authorName: String = "Loading..."  // Имя автора поста
    
    // Инициализируем загрузчик изображения
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(spacing: 16) {
            // Заголовок поста с автором
            Text(authorName)
                .font(.headline)
            
            // Изображение поста
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
            } else if let errorMessage = errorMessage {
                // Если ошибка при загрузке изображения, показываем сообщение
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                // Плейсхолдер или индикатор загрузки
                ProgressView("Loading Image...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            
            // Контент поста
            Text(post.content)
                .font(.body)
                .lineLimit(nil)  // Позволяем отображать весь текст, не ограничивая количество строк
            
            // Количество лайков
            Text("\(post.likes) Likes")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .onAppear {
            loadImage()
            loadAuthorName()
        }
    }
    
    // Метод для загрузки изображения
    private func loadImage() {
        if let url = post.imageURL { // Безопасно развертываем опциональный URL
            imageLoader.loadImage(url: url)
            imageLoader.completionHandler = { image in
                // Убираем использование weak self, если это возможно
                if let image = image {
                    self.loadedImage = image // Обновляем UI с загруженным изображением
                } else {
                    self.errorMessage = "Failed to load image." // Если загрузка не удалась
                }
            }
        } else {
            self.errorMessage = "No image URL available." // Если URL отсутствует
        }
    }


    
    // Метод для загрузки имени автора
    private func loadAuthorName() {
        // Замените этот метод на реальную логику, чтобы получить имя автора по его ID.
        // Например, запросить API или загрузить из базы данных.
        // Для демонстрации возьмем просто строку:
        
        // Пример:
        self.authorName = "User \(post.authorId.uuidString)"
    }
}

// Делегат для обработки ошибок при загрузке изображения
class ImageLoaderDelegateWrapper: ImageLoaderDelegate {
    private let failureHandler: (ImageLoader, Error) -> Void
    
    init(failureHandler: @escaping (ImageLoader, Error) -> Void) {
        self.failureHandler = failureHandler
    }
    
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage) {
        // Не используется в данном примере
    }
    
    func imageLoader(_ loader: ImageLoader, didFailWith error: Error) {
        failureHandler(loader, error)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: Post(id: UUID(), authorId: UUID(), content: "This is a post content.", likes: 120))
    }
}
