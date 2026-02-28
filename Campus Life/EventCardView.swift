import SwiftUI

struct EventCardView: View {
    let event: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // BANNER
            ZStack(alignment: .bottomLeading) {
                LinearGradient(
                    colors: [Color.campusBlue, Color.campusBlue.opacity(0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 100)
                .clipShape(RoundedCornerShape(radius: 16, corners: [.topLeft, .topRight]))

                Text(event.emoji)
                    .font(.system(size: 50))
                    .padding(12)

                // PRECIO
                HStack {
                    Spacer()
                    Text(event.isFree ? "GRATIS" : "$\(String(format: "%.0f", event.price))")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(event.isFree ? Color.green : Color.white.opacity(0.25))
                        .cornerRadius(100)
                        .padding(12)
                }
            }

            // INFO
            VStack(alignment: .leading, spacing: 10) {

                Text(event.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.campusText)
                    .lineLimit(2)

                HStack(spacing: 16) {
                    Label(event.date, systemImage: "calendar")
                    Label(event.time, systemImage: "clock")
                }
                .font(.system(size: 12))
                .foregroundColor(.campusGray)

                Label(event.location, systemImage: "mappin.circle.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.campusGray)
                    .lineLimit(1)

                // ASISTENTES Y BARRA DE CAPACIDAD
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 11))
                        Text("\(event.attendees) asistentes")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.campusGray)

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        Text("\(event.attendees)/\(event.capacity)")
                            .font(.system(size: 10))
                            .foregroundColor(.campusGray)
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.campusBorder)
                                    .frame(height: 4)
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.campusBlue)
                                    .frame(width: geo.size.width * CGFloat(event.attendees) / CGFloat(event.capacity), height: 4)
                            }
                        }
                        .frame(width: 80, height: 4)
                    }
                }
            }
            .padding(14)
        }
        .background(Color.campusCard)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
    }
}

// Helper para redondear solo esquinas específicas
struct RoundedCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    EventCardView(event: Event.sampleEvents[0])
        .padding()
        .background(Color.campusBG)
}
