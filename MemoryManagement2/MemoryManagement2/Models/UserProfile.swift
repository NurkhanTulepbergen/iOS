import Foundation

struct UserProfile: Hashable, Equatable {
    let id: UUID
    let username: String
    var bio: String
    var followers: Int
    
    // Implement Hashable using immutable properties
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(username)
    }
    
    // Implement Equatable using immutable properties
    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.id == rhs.id && lhs.username == rhs.username
    }
}
