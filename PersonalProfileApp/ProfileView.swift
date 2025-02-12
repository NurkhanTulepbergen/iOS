import SwiftUI

struct ProfileView: View {
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            
            NavigationView {
                Group {
                    if isLandscape {
                        HStack {
                            VStack {
                                profileImage()
                                userInfo()
                            }
                            .frame(maxWidth: geometry.size.width)
                            
                            Spacer()
                            
                            buttonSection()
                                .frame(maxWidth: geometry.size.width )
                        }
                        .padding()
                    } else {
                        VStack(spacing: 20) {
                            profileImage()
                            userInfo()
                            buttonSection()
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground)) 
            }
            .navigationViewStyle(StackNavigationViewStyle()) 
        }
    }
    
    private func profileImage() -> some View {
        Image("photo")
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.green, lineWidth: 2))
            .shadow(radius: 20)
    }
    
    private func userInfo() -> some View {
        VStack(spacing: 10) {
            Text("Nurkhan Tulepbegren")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Age:19")
                .font(.subheadline)
                .foregroundColor(.green)
            
            Text("City:Almaty")
                .font(.subheadline)
                .foregroundColor(.green)
            
            Text("About me: IT Student who is looking for himself in this industry")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
    
    private func buttonSection() -> some View {
        VStack(spacing: 15) {
            NavigationLink(destination: HobbiesView()) {
                Text("My hobbies")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: GoalsView()) {
                Text("My goals")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: 200) 
    }
}

