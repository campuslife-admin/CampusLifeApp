import SwiftUI

struct FilterSheetView: View {
    @Binding var selectedDate: Date?
    @Binding var selectedZona: String
    let zonas: [String]
    @Environment(\.dismiss) var dismiss
    @State private var tempDate: Date = Date()
    @State private var showCalendar = false
    @State private var tempZona: String

    init(selectedDate: Binding<Date?>, selectedZona: Binding<String>, zonas: [String]) {
        self._selectedDate = selectedDate
        self._selectedZona = selectedZona
        self.zonas = zonas
        self._tempZona = State(initialValue: selectedZona.wrappedValue)
    }

    var body: some View {
        ZStack {
            Color.campusCard.ignoresSafeArea()

            VStack(spacing: 0) {

                // HEADER
                HStack {
                    Button("Limpiar") {
                        selectedDate = nil
                        selectedZona = "Todas"
                        dismiss()
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.campusGray)

                    Spacer()

                    Text("Filtros")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.campusText)

                    Spacer()

                    Button("Aplicar") {
                        selectedZona = tempZona
                        dismiss()
                    }
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.campusBlue)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)

                Divider().background(Color.campusBorder)

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {

                        // FECHA
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Fecha")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.campusText)

                            HStack(spacing: 10) {
                                ForEach(["Hoy", "Mañana", "Este finde"], id: \.self) { option in
                                    Button {
                                        if option == "Hoy" {
                                            selectedDate = Date()
                                        } else if option == "Mañana" {
                                            selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
                                        } else {
                                            selectedDate = nextWeekend()
                                        }
                                    } label: {
                                        Text(option)
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundColor(.campusText)
                                            .padding(.horizontal, 14)
                                            .padding(.vertical, 8)
                                            .background(Color.campusBG)
                                            .cornerRadius(100)
                                            .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.campusBorder, lineWidth: 1.5))
                                    }
                                }
                            }

                            Button {
                                showCalendar.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.campusBlue)
                                    Text(selectedDate != nil
                                         ? selectedDate!.formatted(.dateTime.day().month().year())
                                         : "Elegir fecha específica")
                                        .font(.system(size: 14))
                                        .foregroundColor(selectedDate != nil ? .campusText : .campusGray)
                                    Spacer()
                                    Image(systemName: showCalendar ? "chevron.up" : "chevron.down")
                                        .font(.system(size: 12))
                                        .foregroundColor(.campusGray)
                                }
                                .padding(14)
                                .background(Color.campusBG)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.campusBorder, lineWidth: 1.5))
                            }

                            if showCalendar {
                                DatePicker(
                                    "",
                                    selection: $tempDate,
                                    in: Date()...,
                                    displayedComponents: .date
                                )
                                .datePickerStyle(.graphical)
                                .tint(.campusBlue)
                                .onChange(of: tempDate) { newDate in
                                    selectedDate = newDate
                                    showCalendar = false
                                }
                            }
                        }

                        Divider().background(Color.campusBorder)

                        // ZONA
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Zona")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.campusText)

                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 10) {
                                ForEach(zonas, id: \.self) { zona in
                                    Button {
                                        tempZona = zona
                                    } label: {
                                        Text(zona)
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundColor(tempZona == zona ? .white : .campusText)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 10)
                                            .background(tempZona == zona ? Color.campusBlue : Color.campusBG)
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(tempZona == zona ? Color.campusBlue : Color.campusBorder, lineWidth: 1.5)
                                            )
                                    }
                                }
                            }
                        }
                    }
                    .padding(20)
                }

                // BOTÓN APLICAR
                Button {
                    selectedZona = tempZona
                    dismiss()
                } label: {
                    Text("Aplicar filtros")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.campusBlue)
                        .cornerRadius(14)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
    }

    func nextWeekend() -> Date {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let daysUntilSaturday = (7 - weekday + 7) % 7
        return calendar.date(byAdding: .day, value: daysUntilSaturday == 0 ? 7 : daysUntilSaturday, to: today) ?? today
    }
}

#Preview {
    FilterSheetView(
        selectedDate: .constant(nil),
        selectedZona: .constant("Todas"),
        zonas: ["Todas", "Casco", "Amador", "Marbella"]
    )
}
