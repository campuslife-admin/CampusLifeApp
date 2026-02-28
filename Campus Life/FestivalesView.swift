import SwiftUI

struct FestivalesView: View {
    let searchText: String
    @State private var showFilters = false
    @State private var selectedDate: Date? = nil
    @State private var selectedZona = "Todas"

    let zonas = ["Todas", "Ciudad de Panamá", "Interior", "Bocas del Toro", "Chiriquí"]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                filterBar
                if selectedDate != nil || selectedZona != "Todas" { activeFilters }

                VStack(spacing: 12) {
                    Text("🎪")
                        .font(.system(size: 50))
                        .padding(.top, 40)
                    Text("Próximos festivales")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.campusText)
                    Text("Los festivales universitarios aparecerán aquí pronto")
                        .font(.system(size: 14))
                        .foregroundColor(.campusGray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
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
            Text("0 festivales")
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
                    activeChipLight(text: date.formatted(.dateTime.day().month()), color: .campusBlue) { selectedDate = nil }
                }
                if selectedZona != "Todas" {
                    activeChipLight(text: selectedZona, color: .purple) { selectedZona = "Todas" }
                }
            }
            .padding(.horizontal, 20)
        }
    }

    func activeChipLight(text: String, color: Color, onRemove: @escaping () -> Void) -> some View {
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

#Preview {
    NavigationStack { FestivalesView(searchText: "") }
}
