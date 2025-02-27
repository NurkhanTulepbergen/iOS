import Foundation
import Combine

protocol ProfileUpdateDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}

class ProfileManager: ObservableObject {
    @Published private var activeProfiles: [UUID: UserProfile] = [:]
    
    weak var delegate: ProfileUpdateDelegate?
    var onProfileUpdate: ((UserProfile) -> Void)?
    
    init(delegate: ProfileUpdateDelegate?) {
        self.delegate = delegate
    }
    
    func getProfile(for id: UUID) -> UserProfile? {
        return activeProfiles[id]
    }
    
    func loadProfile(id: UUID, username: String, bio: String, followers: Int, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        DispatchQueue.global().async {
            let profile = UserProfile(id: id, username: username, bio: bio, followers: followers)
            
            self.activeProfiles[id] = profile
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                completion(.success(profile))
                
                self.delegate?.profileDidUpdate(profile)
                
                self.onProfileUpdate?(profile)
            }
        }
    }
}
