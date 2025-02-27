import SwiftUI

struct UserProfileView: View {
    // Используем @State для изменения профиля в View
    @State private var profile: UserProfile?  // Профиль теперь можно изменять
    
    // Храним ссылку на ProfileManager
    @StateObject private var profileManager = ProfileManager(delegate: nil)
    
    // Текст ошибки, если загрузка профиля не удалась
    @State private var errorMessage: String?
    
    // Загрузка профиля с параметрами
    func loadProfile() {
        profileManager.loadProfile(id: UUID(), username: "Nurkhan", bio: "Here need to be something, but I am too lazy for create it", followers: 150) { result in
            switch result {
            case .success(let profile):
                self.profile = profile  // Теперь можно изменять профиль
            case .failure(let error):
                self.errorMessage = "Error loading profile: \(error.localizedDescription)"
            }
        }
    }
    
    var body: some View {
        VStack {
            if let profile = profile {
                // Если профиль загружен, отображаем данные
                Text("Username: \(profile.username)")
                    .font(.title)
                    .padding()
                
                Text("Bio: \(profile.bio)")
                    .padding()
                
                Text("Followers: \(profile.followers)")
                    .padding()
            } else {
                // Если профиль еще не загружен, показываем кнопку для загрузки
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
            
            // Показываем ошибку, если она возникла
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            // Загрузим профиль при появлении представления
            loadProfile()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()  // Теперь можно просто создать экземпляр без параметров
    }
}
