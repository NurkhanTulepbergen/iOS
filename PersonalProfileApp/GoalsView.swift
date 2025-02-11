import SwiftUI

struct Goal: Identifiable {
    let id = UUID()
    let title: String
    let year: Int
}

struct GoalsView: View {
    let goals = [
        Goal(title: "Learn ios, php, android", year: 2025),
        Goal(title: "Make app for store", year: 2025),
        Goal(title: "Fly to America", year: 2025),
        Goal(title: "Find a profession to my liking", year: 2025)
    ]
    
    var body: some View {
        List(goals) { goal in
            HStack {
                Text("\(goal.year)")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(goal.title)
                    .font(.body)
            }
        }
        .navigationTitle("Ny goals")
    }
}
