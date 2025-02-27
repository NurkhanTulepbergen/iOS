import SwiftUI

struct UserProfileView: View {
    @State private var profile: UserProfile?
    
    @StateObject private var profileManager = ProfileManager(delegate: nil)
    
    @State private var errorMessage: String?
    
    func loadProfile() {
        profileManager.loadProfile(id: UUID(), username: "Nurkhan", bio: "Here need to be something, but I am too lazy for create it", followers: 150) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.errorMessage = "Error loading profile: \(error.localizedDescription)"
            }
        }
    }
    
    var body: some View {
        VStack {
            if let profile = profile {
                Text("Username: \(profile.username)")
                    .font(.title)
                    .padding()
                
                Text("Bio: \(profile.bio)")
                    .padding()
                
                Text("Followers: \(profile.followers)")
                    .padding()
            } else {
                Text("No Profile Available")
                    .padding()
                
                Button(action: loadProfile) {
                    Text("Load Profile")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            loadProfile()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView() 
    }
}
