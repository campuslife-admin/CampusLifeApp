import SwiftUI

struct WalletView: View {
    let student = Student.sampleStudent
    @State private var selectedTab = "Boletos"

    let tabs = ["Boletos", "Cupones"]

    var body: some View {
        ZStack {
            Color.campusBG.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // HEADER
                    HStack {
                        Text("Wallet")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundColor(.campusText)
                        Spacer()
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.campusBlue)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 20)

                    // CARD RESUMEN (mantiene el gradiente — es la tarjeta)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(
                                colors: [Color.campusBlue, Color.campusBlue.opacity(0.7)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(height: 140)
                            .shadow(color: Color.campusBlue.opacity(0.3), radius: 16, x: 0, y: 8)

                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("🎓 Campus Life")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white.opacity(0.85))
                                Spacer()
                                Image(systemName: "qrcode")
                                    .foregroundColor(.white.opacity(0.6))
                                    .font(.system(size: 20))
                            }
                            Spacer()
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(student.name)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                    Text(student.university)
                                        .font(.system(size: 11))
                                        .foregroundColor(.white.opacity(0.65))
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("\(student.ticketsCount) boletos")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(.white)
                                    Text("\(student.couponsCount) cupones")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white.opacity(0.75))
                                }
                            }
                        }
                        .padding(20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)

                    // TABS
                    HStack(spacing: 0) {
                        ForEach(tabs, id: \.self) { tab in
                            Button {
                                selectedTab = tab
                            } label: {
                                VStack(spacing: 8) {
                                    Text(tab)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(selectedTab == tab ? .campusBlue : .campusGray)
                                    Rectangle()
                                        .fill(selectedTab == tab ? Color.campusBlue : Color.clear)
                                        .frame(height: 2)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 20)
                    .background(Color.campusCard)

                    Divider().background(Color.campusBorder)

                    walletContent
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    var walletContent: some View {
        if selectedTab == "Boletos" {
            boletosTab
        } else {
            cuponesTab
        }
    }

    var boletosTab: some View {
        VStack(spacing: 12) {
            ForEach(["FURIA ON CAMPUS 🌙", "Pasadía Pozos Azules ✈️", "Chill Out Viernes 🎉", "Torneo Fútbol ⚽"], id: \.self) { ticket in
                HStack(spacing: 14) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.campusBlue.opacity(0.1))
                            .frame(width: 44, height: 44)
                        Image(systemName: "ticket.fill")
                            .foregroundColor(.campusBlue)
                            .font(.system(size: 18))
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(ticket)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.campusText)
                        Text("Boleto válido")
                            .font(.system(size: 12))
                            .foregroundColor(.campusGray)
                    }
                    Spacer()
                    Image(systemName: "qrcode")
                        .foregroundColor(.campusBlue)
                        .font(.system(size: 20))
                }
                .padding(14)
                .background(Color.campusCard)
                .cornerRadius(14)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
            }
        }
        .padding(16)
    }

    var cuponesTab: some View {
        VStack(spacing: 12) {
            ForEach(["20% off Tacos La Neta 🌮", "2x1 en Café Unido ☕", "15% off Ropa Deportiva 👟", "Entrada gratis al gym 🏋️"], id: \.self) { coupon in
                HStack(spacing: 14) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.green.opacity(0.1))
                            .frame(width: 44, height: 44)
                        Image(systemName: "tag.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 18))
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(coupon)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.campusText)
                        Text("Toca para usar")
                            .font(.system(size: 12))
                            .foregroundColor(.campusGray)
                    }
                    Spacer()
                    Text("Usar")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 7)
                        .background(Color.green)
                        .cornerRadius(100)
                }
                .padding(14)
                .background(Color.campusCard)
                .cornerRadius(14)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
            }
        }
        .padding(16)
    }
}

#Preview {
    WalletView()
}
