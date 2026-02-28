import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }

            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explorar")
                }

            CommunitiesView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Comunidades")
                }

            CuponesTabView()
                .tabItem {
                    Image(systemName: "tag.fill")
                    Text("Cupones")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }
        }
        .tint(.campusBlue)
        .preferredColorScheme(.light)
    }
}

#Preview {
    MainTabView()
}
