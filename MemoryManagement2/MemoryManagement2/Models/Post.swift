import Foundation

struct Post: Hashable, Equatable {
    let id: UUID
    let authorId: UUID
    var content: String
    var likes: Int
    var imageURL: URL?  // Добавляем поле для URL изображения
    
    // Implement Hashable using immutable properties
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(authorId)
    }
    
    // Implement Equatable using immutable properties
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id && lhs.authorId == rhs.authorId
    }
    
    func getAuthorUsername(from manager: ProfileManager) -> String? {
        guard let profile = manager.getProfile(for: authorId) else {
            return nil // Если профиля нет, возвращаем nil
        }
        return profile.username
    }
}
    
