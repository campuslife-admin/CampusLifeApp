import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "Discoteca"

    let categories = ["Discoteca", "Festivales", "Trips", "Actividades"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.campusBG.ignoresSafeArea()

                VStack(spacing: 0) {

                    // HEADER
                    HStack {
                        Text("Explorar")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundColor(.campusText)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 14)

                    // SEARCH BAR
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.campusGray)
                        TextField("Buscar eventos, lugares...", text: $searchText)
                            .foregroundColor(.campusText)
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.campusGray)
                            }
                        }
                    }
                    .padding(13)
                    .background(Color.campusCard)
                    .cornerRadius(13)
                    .overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.campusBorder, lineWidth: 1.5))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)

                    // CATEGORÍAS
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories, id: \.self) { category in
                                Button {
                                    selectedCategory = category
                                } label: {
                                    HStack(spacing: 6) {
                                        Text(categoryEmoji(category))
                                        Text(category)
                                    }
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(selectedCategory == category ? .white : .campusText)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 9)
                                    .background(selectedCategory == category ? Color.campusBlue : Color.campusCard)
                                    .cornerRadius(100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100)
                                            .stroke(selectedCategory == category ? Color.campusBlue : Color.campusBorder, lineWidth: 1.5)
                                    )
                                    .shadow(
                                        color: selectedCategory == category ? Color.campusBlue.opacity(0.25) : .clear,
                                        radius: 8, x: 0, y: 3
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 2)
                    }
                    .padding(.bottom, 4)

                    Divider()
                        .background(Color.campusBorder)

                    categoryContent
                }
            }
        }
    }

    func categoryEmoji(_ category: String) -> String {
        switch category {
        case "Discoteca":   return "🌙"
        case "Festivales":  return "🎪"
        case "Trips":       return "✈️"
        case "Actividades": return "🏄"
        default: return ""
        }
    }

    @ViewBuilder
    var categoryContent: some View {
        switch selectedCategory {
        case "Discoteca":   DiscotecaView(searchText: searchText)
        case "Festivales":  FestivalesView(searchText: searchText)
        case "Trips":       TripsView(searchText: searchText)
        case "Actividades": ActividadesView(searchText: searchText)
        default: EmptyView()
        }
    }
}

#Preview {
    ExploreView()
}
