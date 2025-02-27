import Foundation
import Combine

protocol ProfileUpdateDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}

class ProfileManager: ObservableObject {
    // Change the dictionary to use UUID as the key instead of String
    @Published private var activeProfiles: [UUID: UserProfile] = [:]
    
    weak var delegate: ProfileUpdateDelegate?
    var onProfileUpdate: ((UserProfile) -> Void)?
    
    init(delegate: ProfileUpdateDelegate?) {
        self.delegate = delegate
    }
    
    // Method to get a profile by UUID key
    func getProfile(for id: UUID) -> UserProfile? {
        return activeProfiles[id]
    }
    
    // Update loadProfile to use UUID for id
    func loadProfile(id: UUID, username: String, bio: String, followers: Int, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        DispatchQueue.global().async {
            // Simulate loading the profile (using UUID as id)
            let profile = UserProfile(id: id, username: username, bio: bio, followers: followers)
            
            // Save the profile in the activeProfiles dictionary with UUID key
            self.activeProfiles[id] = profile
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                // Call the completion handler
                completion(.success(profile))
                
                // Notify the delegate about the profile update
                self.delegate?.profileDidUpdate(profile)
                
                // Call the onProfileUpdate closure if it's set
                self.onProfileUpdate?(profile)
            }
        }
    }
}
