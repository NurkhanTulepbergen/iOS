import Foundation
import Combine

protocol ProfileUpdateDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}

class ProfileManager: ObservableObject {
    // Mark activeProfiles as private to encapsulate it
    @Published private var activeProfiles: [String: UserProfile] = [:]
    weak var delegate: ProfileUpdateDelegate?
    var onProfileUpdate: ((UserProfile) -> Void)?
    
    init(delegate: ProfileUpdateDelegate?) {
        self.delegate = delegate
    }
    
    // Add a computed property or method to access activeProfiles
    func getProfile(for id: String) -> UserProfile? {
        return activeProfiles[id]
    }
    
    func loadProfile(id: String, username: String, bio: String, followers: Int, completion: @escaping (Result<UserProfile, Error>) -> Void) {
            DispatchQueue.global().async {
                // Simulate profile loading with custom username, bio, and followers count
                let profile = UserProfile(id: UUID(), username: username, bio: bio, followers: followers)
                
                // Save the profile in the activeProfiles dictionary
                self.activeProfiles[id] = profile
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    // Call the completion handler with the created profile
                    completion(.success(profile))
                    // Notify the delegate about the profile update
                    self.delegate?.profileDidUpdate(profile)
                    // Call the onProfileUpdate closure if it's set
                    self.onProfileUpdate?(profile)
                }
            }
        }
}
