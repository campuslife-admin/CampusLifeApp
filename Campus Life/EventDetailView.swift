import SwiftUI

struct EventDetailView: View {
    let event: Event
    @State private var showPurchase = false
    @State private var ticketCount = 1

    var body: some View {
        ZStack {
            Color.campusBG.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // BANNER
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(
                            colors: [Color.campusBlue, Color.campusBlue.opacity(0.75)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 280)

                        VStack(alignment: .leading, spacing: 8) {
                            Text(event.emoji)
                                .font(.system(size: 60))

                            Text(event.title)
                                .font(.system(size: 26, weight: .heavy))
                                .foregroundColor(.white)
                                .lineLimit(2)

                            HStack(spacing: 8) {
                                Text(event.isFree ? "GRATIS" : "$\(String(format: "%.0f", event.price))")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(event.isFree ? Color.green : Color.white.opacity(0.25))
                                    .cornerRadius(100)

                                Text("por \(event.organizer)")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white.opacity(0.75))
                            }
                        }
                        .padding(20)
                    }

                    VStack(alignment: .leading, spacing: 20) {

                        // STATS RÁPIDOS
                        HStack(spacing: 0) {
                            quickStat(icon: "person.2.fill", value: "\(event.attendees)", label: "Asistentes", color: .campusBlue)
                            Divider().frame(height: 40).background(Color.campusBorder)
                            quickStat(icon: "person.crop.circle", value: "\(event.capacity - event.attendees)", label: "Disponibles", color: .green)
                            Divider().frame(height: 40).background(Color.campusBorder)
                            quickStat(icon: "clock.fill", value: event.time, label: "Hora", color: .orange)
                        }
                        .padding(.vertical, 16)
                        .background(Color.campusCard)
                        .cornerRadius(14)
                        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)

                        // DETALLES
                        VStack(spacing: 12) {
                            detailRow(icon: "calendar", text: event.date, color: .campusBlue)
                            detailRow(icon: "clock.fill", text: event.time, color: .orange)
                            detailRow(icon: "mappin.circle.fill", text: event.location, color: .red)
                        }
                        .padding(16)
                        .background(Color.campusCard)
                        .cornerRadius(14)
                        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)

                        // CAPACIDAD
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Capacidad")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.campusText)
                                Spacer()
                                Text("\(event.attendees) de \(event.capacity)")
                                    .font(.system(size: 13))
                                    .foregroundColor(.campusGray)
                            }

                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.campusBorder)
                                        .frame(height: 8)
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(capacityColor)
                                        .frame(width: geo.size.width * CGFloat(event.attendees) / CGFloat(event.capacity), height: 8)
                                }
                            }
                            .frame(height: 8)

                            Text(capacityMessage)
                                .font(.system(size: 12))
                                .foregroundColor(capacityColor)
                        }
                        .padding(16)
                        .background(Color.campusCard)
                        .cornerRadius(14)
                        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)

                        // DESCRIPCIÓN
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Acerca del evento")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.campusText)
                            Text(event.description)
                                .font(.system(size: 14))
                                .foregroundColor(.campusGray)
                                .lineSpacing(5)
                        }

                        // CANTIDAD DE BOLETOS
                        if !event.isFree {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Cantidad de boletos")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.campusText)

                                HStack {
                                    Button {
                                        if ticketCount > 1 { ticketCount -= 1 }
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .fill(Color.campusBG)
                                                .frame(width: 40, height: 40)
                                                .overlay(Circle().stroke(Color.campusBorder, lineWidth: 1.5))
                                            Image(systemName: "minus")
                                                .foregroundColor(.campusText)
                                                .font(.system(size: 16, weight: .semibold))
                                        }
                                    }

                                    Text("\(ticketCount)")
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(.campusText)
                                        .frame(width: 50, alignment: .center)

                                    Button {
                                        if ticketCount < 5 { ticketCount += 1 }
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .fill(Color.campusBlue)
                                                .frame(width: 40, height: 40)
                                            Image(systemName: "plus")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .semibold))
                                        }
                                    }

                                    Spacer()

                                    Text("Total: $\(String(format: "%.0f", event.price * Double(ticketCount)))")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.campusText)
                                }
                            }
                            .padding(16)
                            .background(Color.campusCard)
                            .cornerRadius(14)
                            .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
                        }

                        // BOTÓN COMPRAR
                        Button {
                            showPurchase = true
                        } label: {
                            HStack {
                                Spacer()
                                Image(systemName: event.isFree ? "checkmark.circle.fill" : "creditcard.fill")
                                    .font(.system(size: 16))
                                Text(event.isFree
                                     ? "Registrarme gratis"
                                     : "Comprar \(ticketCount) boleto\(ticketCount > 1 ? "s" : "") — $\(String(format: "%.0f", event.price * Double(ticketCount)))")
                                    .font(.system(size: 16, weight: .bold))
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                            .background(event.isFree ? Color.green : Color.campusBlue)
                            .cornerRadius(14)
                        }
                        .padding(.bottom, 30)
                    }
                    .padding(20)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showPurchase) {
            TicketPurchaseView(event: event, ticketCount: ticketCount)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }

    var capacityColor: Color {
        let percentage = Double(event.attendees) / Double(event.capacity)
        if percentage >= 0.9 { return .red }
        if percentage >= 0.7 { return .orange }
        return .green
    }

    var capacityMessage: String {
        let percentage = Double(event.attendees) / Double(event.capacity)
        if percentage >= 0.9 { return "🔥 Casi lleno — quedan pocos boletos" }
        if percentage >= 0.7 { return "⚡ Llenándose rápido" }
        return "✅ Boletos disponibles"
    }

    func quickStat(icon: String, value: String, label: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon).foregroundColor(color).font(.system(size: 14))
            Text(value).font(.system(size: 15, weight: .bold)).foregroundColor(.campusText)
            Text(label).font(.system(size: 10)).foregroundColor(.campusGray)
        }
        .frame(maxWidth: .infinity)
    }

    func detailRow(icon: String, text: String, color: Color) -> some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.12))
                    .frame(width: 32, height: 32)
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 13))
            }
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.campusGray)
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        EventDetailView(event: Event.sampleEvents[0])
    }
}
