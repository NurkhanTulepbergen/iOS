import SwiftUI

struct FeedView: View {
    let posts: [Post]
    let profileManager: ProfileManager

    var body: some View {
        List(posts, id: \.id) { post in
            PostView(post: post, profileManager: profileManager)
        }
        .navigationTitle("Лента")
    }
}
