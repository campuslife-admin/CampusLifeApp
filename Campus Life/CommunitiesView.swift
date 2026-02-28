import SwiftUI

struct CommunitiesView: View {
    let communities = Community.sampleCommunities
    @State private var selectedFilter = "Todas"

    let filters = ["Todas", "Siguiendo", "Social", "Deportes", "Tecnología"]

    var filteredCommunities: [Community] {
        if selectedFilter == "Todas" {
            return communities
        } else if selectedFilter == "Siguiendo" {
            return communities.filter { $0.isJoined }
        } else {
            return communities.filter { $0.category == selectedFilter }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.campusBG.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // HEADER
                        HStack {
                            Text("Comunidades")
                                .font(.system(size: 28, weight: .heavy))
                                .foregroundColor(.campusText)
                            Spacer()
                            Button {} label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.campusCard)
                                        .frame(width: 40, height: 40)
                                        .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: 2)
                                    Image(systemName: "magnifyingglass")
                                        .font(.system(size: 17, weight: .medium))
                                        .foregroundColor(.campusText)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 16)

                        // FILTROS
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(filters, id: \.self) { filter in
                                    Button {
                                        selectedFilter = filter
                                    } label: {
                                        Text(filter)
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundColor(selectedFilter == filter ? .white : .campusText)
                                            .padding(.horizontal, 14)
                                            .padding(.vertical, 9)
                                            .background(selectedFilter == filter ? Color.campusBlue : Color.campusCard)
                                            .cornerRadius(100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 100)
                                                    .stroke(selectedFilter == filter ? Color.campusBlue : Color.campusBorder, lineWidth: 1.5)
                                            )
                                            .shadow(
                                                color: selectedFilter == filter ? Color.campusBlue.opacity(0.25) : .clear,
                                                radius: 8, x: 0, y: 3
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 2)
                        }
                        .padding(.bottom, 16)

                        // LABEL EDITORIAL
                        HStack(spacing: 10) {
                            Text("COMUNIDADES")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.campusBlue)
                                .tracking(1.6)
                            Rectangle()
                                .fill(Color.campusBorder)
                                .frame(height: 1)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)

                        // LISTA
                        LazyVStack(spacing: 10) {
                            ForEach(filteredCommunities) { community in
                                NavigationLink(destination: CommunityDetailView(community: community)) {
                                    CommunityCardView(community: community)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
    }
}

#Preview {
    CommunitiesView()
}
