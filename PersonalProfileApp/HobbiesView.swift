import SwiftUI

struct Hobby: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let description: String
}

struct HobbiesView: View {
    let hobbies = [
        Hobby(name: "Programing", icon: "💻", description: "Try to programm some applications"),
        Hobby(name: "Soccer", icon: "⚽️", description: "One time a month we play a soccer with groupmates"),
        Hobby(name: "Reading", icon: "📚", description: "Try to read books in free time(it doesn't always work)"),
        Hobby(name: "Chess", icon: "🏁", description: "Since 2022 I play chess, and my elo is 1150")
    ]
    
    var body: some View {
        List(hobbies) { hobby in
            HStack {
                Text(hobby.icon)
                    .font(.largeTitle)
                
                VStack(alignment: .leading) {
                    Text(hobby.name)
                        .font(.headline)
                    Text(hobby.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(5)
        }
        .navigationTitle("My hobbies")
    }
}
