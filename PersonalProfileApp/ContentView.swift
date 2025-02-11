import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            
            if isLandscape {
                HStack {
                    ProfileView()
                }
            } else {
                VStack {
                    ProfileView()
                }
            }
        }
        .edgesIgnoringSafeArea(.all) 
    }
}
