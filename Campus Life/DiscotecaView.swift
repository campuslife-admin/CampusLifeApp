import SwiftUI

struct DiscotecaView: View {
    let searchText: String
    @State private var showFilters = false
    @State private var selectedDate: Date? = nil
    @State private var selectedZona = "Todas"

    let zonas = ["Todas", "Casco", "Amador", "Marbella", "Costa del Este", "San Francisco"]

    var filteredEvents: [Event] {
        Event.sampleEvents.filter { event in
            searchText.isEmpty ||
            event.title.localizedCaseInsensitiveContains(searchText) ||
            event.location.localizedCaseInsensitiveContains(searchText) ||
            event.organizer.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {

                filterBar

                if selectedDate != nil || selectedZona != "Todas" {
                    activeFilters
                }

                if filteredEvents.isEmpty {
                    emptyState(text: searchText)
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredEvents) { event in
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
        .sheet(isPresented: $showFilters) {
            FilterSheetView(selectedDate: $selectedDate, selectedZona: $selectedZona, zonas: zonas)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    var filterBar: some View {
        HStack {
            Text("\(filteredEvents.count) eventos")
                .font(.system(size: 14))
                .foregroundColor(.campusGray)
            Spacer()
            Button { showFilters = true } label: {
                HStack(spacing: 6) {
                    Image(systemName: "slider.horizontal.3")
                    Text("Filtrar")
                }
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.campusText)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.campusCard)
                .cornerRadius(100)
                .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.campusBorder, lineWidth: 1.5))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }

    var activeFilters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                if let date = selectedDate {
                    activeChip(text: date.formatted(.dateTime.day().month()), color: .campusBlue) { selectedDate = nil }
                }
                if selectedZona != "Todas" {
                    activeChip(text: selectedZona, color: .purple) { selectedZona = "Todas" }
                }
            }
            .padding(.horizontal, 20)
        }
    }

    func activeChip(text: String, color: Color, onRemove: @escaping () -> Void) -> some View {
        HStack(spacing: 6) {
            Text(text).font(.system(size: 12, weight: .semibold)).foregroundColor(color)
            Button(action: onRemove) {
                Image(systemName: "xmark").font(.system(size: 10, weight: .bold)).foregroundColor(color.opacity(0.7))
            }
        }
        .padding(.horizontal, 12).padding(.vertical, 6)
        .background(color.opacity(0.1)).cornerRadius(100)
        .overlay(RoundedRectangle(cornerRadius: 100).stroke(color.opacity(0.3), lineWidth: 1))
    }
}

func emptyState(text: String) -> some View {
    VStack(spacing: 12) {
        Text("🔍")
            .font(.system(size: 40))
            .padding(.top, 40)
        Text("Sin resultados")
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.campusText)
        Text(text.isEmpty ? "No hay eventos disponibles" : "No encontramos eventos para \"\(text)\"")
            .font(.system(size: 14))
            .foregroundColor(.campusGray)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    NavigationStack { DiscotecaView(searchText: "") }
}
