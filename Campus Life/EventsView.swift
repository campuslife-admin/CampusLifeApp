import SwiftUI

struct EventsView: View {
    let events = Event.sampleEvents
    @State private var selectedCategory = "Todos"

    let categories = ["Todos", "🌙 Nightlife", "✈️ Trips", "🤖 Tech", "⚽ Sports", "🎉 Social"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.campusBG.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // HEADER
                        HStack {
                            Text("Eventos")
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

                        // CATEGORÍAS
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(categories, id: \.self) { category in
                                    Button {
                                        selectedCategory = category
                                    } label: {
                                        Text(category)
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
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 2)
                        }
                        .padding(.bottom, 16)

                        // LISTA DE EVENTOS
                        LazyVStack(spacing: 12) {
                            ForEach(events) { event in
                                NavigationLink(destination: EventDetailView(event: event)) {
                                    EventCardView(event: event)
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
    EventsView()
}
