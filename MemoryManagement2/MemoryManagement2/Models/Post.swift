import Foundation

struct Post: Hashable, Equatable {
    let id: UUID
    let authorId: UUID
    var content: String
    var likes: Int
    var imageURL: URL?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(authorId)
    }
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id && lhs.authorId == rhs.authorId
    }
    
    func getAuthorUsername(from manager: ProfileManager) -> String? {
        guard let profile = manager.getProfile(for: authorId) else {
            return nil 
        }
        return profile.username
    }
}
    
