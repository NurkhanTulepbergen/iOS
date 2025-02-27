import Foundation

class FeedSystem {
    private var userCache: [String: UserProfile] = [:]
    private var feedPosts: [Post] = []
    private var hashtags: Set<String> = []
    
    func addPost(_ post: Post) {
        feedPosts.insert(post, at: 0)
        
        let words = post.content.components(separatedBy: " ")
        for word in words where word.hasPrefix("#") {
            hashtags.insert(word)
        }
    }
    
    func removePost(_ post: Post) {
        if let index = feedPosts.firstIndex(where: { $0.id == post.id }) {
            feedPosts.remove(at: index)
        }
        
        let words = post.content.components(separatedBy: " ")
        for word in words where word.hasPrefix("#") {
            if !feedPosts.contains(where: { $0.content.contains(word) }) {
                hashtags.remove(word)
            }
        }
    }
}
