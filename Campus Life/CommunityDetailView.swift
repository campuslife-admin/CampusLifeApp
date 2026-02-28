import SwiftUI

struct HostRowView: View {
    let host: Host

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.campusBlue.opacity(0.09))
                    .frame(width: 50, height: 50)
                Text(host.emoji)
                    .font(.system(size: 22))
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(host.name)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.campusText)
                Text(host.university)
                    .font(.system(size: 12))
                    .foregroundColor(.campusGray)
            }
            Spacer()
            Text(host.role.title)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(
                    host.role == .admin ? Color(red: 0.8, green: 0.6, blue: 0) :
                    host.role == .coAdmin ? .campusBlue : .green
                )
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    host.role == .admin ? Color.yellow.opacity(0.12) :
                    host.role == .coAdmin ? Color.campusBlue.opacity(0.1) :
                    Color.green.opacity(0.1)
                )
                .cornerRadius(100)
        }
        .padding(14)
        .background(Color.campusCard)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

struct CommunityDetailView: View {
    let community: Community
    @State private var joined: Bool
    @State private var selectedTab = "Posts"

    let tabs = ["Posts", "Eventos", "Calendario", "Galería", "Hosts"]

    init(community: Community) {
        self.community = community
        self._joined = State(initialValue: community.isJoined)
    }

    var body: some View {
        ZStack {
            Color.campusBG.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    bannerSection
                    infoSection
                    tabsSection
                    Divider().background(Color.campusBorder)
                    tabContent
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // BANNER
    var bannerSection: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [Color.campusBlue, Color.campusBlue.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 140)

            HStack(alignment: .bottom) {
                Text(community.emoji)
                    .font(.system(size: 60))
                    .padding(16)
                Spacer()
                Button {
                    joined.toggle()
                } label: {
                    Text(joined ? "Siguiendo ✓" : "Seguir")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(joined ? .campusGray : .campusBlue)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(joined ? Color.campusBG : Color.white)
                        .cornerRadius(100)
                }
                .padding(16)
            }
        }
    }

    // INFO
    var infoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(community.name)
                .font(.system(size: 22, weight: .heavy))
                .foregroundColor(.campusText)

            Text(community.description)
                .font(.system(size: 14))
                .foregroundColor(.campusGray)
                .lineSpacing(4)

            HStack(spacing: 20) {
                VStack {
                    Text("\(community.members)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.campusText)
                    Text("Miembros")
                        .font(.system(size: 11))
                        .foregroundColor(.campusGray)
                }
                Divider()
                    .frame(height: 30)
                    .background(Color.campusBorder)
                VStack {
                    Text(community.category)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.campusText)
                    Text("Categoría")
                        .font(.system(size: 11))
                        .foregroundColor(.campusGray)
                }
            }
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color.campusCard)
    }

    // TABS
    var tabsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        VStack(spacing: 8) {
                            Text(tab)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(selectedTab == tab ? .campusBlue : .campusGray)
                                .padding(.horizontal, 16)
                            Rectangle()
                                .fill(selectedTab == tab ? Color.campusBlue : Color.clear)
                                .frame(height: 2)
                        }
                    }
                }
            }
            .padding(.horizontal, 4)
        }
        .background(Color.campusCard)
    }

    // TAB CONTENT
    @ViewBuilder
    var tabContent: some View {
        switch selectedTab {
        case "Posts":
            postsTab
        case "Eventos":
            comingSoonTab(emoji: "🎟️", title: "Eventos", subtitle: "Próximamente verás los eventos de esta comunidad")
        case "Calendario":
            comingSoonTab(emoji: "📅", title: "Calendario", subtitle: "Las fechas importantes de la comunidad aparecerán aquí")
        case "Galería":
            comingSoonTab(emoji: "🖼️", title: "Galería", subtitle: "Fotos y momentos de la comunidad")
        case "Hosts":
            hostsTab
        default:
            EmptyView()
        }
    }

    // POSTS TAB
    var postsTab: some View {
        Group {
            if community.posts.isEmpty {
                VStack(spacing: 12) {
                    Text("💬").font(.system(size: 40))
                    Text("Aún no hay posts")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.campusText)
                    Text("Sé el primero en publicar algo")
                        .font(.system(size: 14))
                        .foregroundColor(.campusGray)
                }
                .padding(40)
            } else {
                LazyVStack(spacing: 14) {
                    ForEach(community.posts) { post in
                        PostCardView(post: post)
                    }
                }
                .padding(16)
            }
        }
    }

    // HOSTS TAB
    var hostsTab: some View {
        VStack(spacing: 12) {
            ForEach(community.hosts) { host in
                HostRowView(host: host)
            }
        }
        .padding(16)
    }

    // COMING SOON
    func comingSoonTab(emoji: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 12) {
            Text(emoji).font(.system(size: 40))
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.campusText)
            Text(subtitle)
                .font(.system(size: 14))
                .foregroundColor(.campusGray)
                .multilineTextAlignment(.center)
        }
        .padding(40)
    }
}

#Preview {
    NavigationStack {
        CommunityDetailView(community: Community.sampleCommunities[0])
    }
}
