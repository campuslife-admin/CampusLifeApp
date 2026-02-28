import SwiftUI

struct ProfileView: View {
    let student = Student.sampleStudent
    @State private var selectedTab = "Actividad"

    let tabs = ["Actividad", "Logros"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.campusBG.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // HEADER BANNER
                        ZStack(alignment: .bottomLeading) {
                            LinearGradient(
                                colors: [Color.campusBlue, Color.campusBlue.opacity(0.75)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(height: 120)

                            HStack(alignment: .bottom) {
                                ZStack {
                                    Circle()
                                        .fill(Color.campusBG)
                                        .frame(width: 84, height: 84)
                                    Circle()
                                        .fill(Color.campusBlue.opacity(0.12))
                                        .frame(width: 80, height: 80)
                                    Text(student.avatarEmoji)
                                        .font(.system(size: 38))
                                }
                                .offset(x: 20, y: 40)

                                Spacer()

                                NavigationLink(destination: DigitalIDView(student: student)) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "qrcode")
                                        Text("Mi ID")
                                    }
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.campusBlue)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.white)
                                    .cornerRadius(100)
                                }
                                .padding(.trailing, 20)
                                .padding(.bottom, 12)
                            }
                        }

                        // INFO
                        VStack(alignment: .leading, spacing: 6) {
                            Text(student.name)
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.campusText)

                            Text(student.university)
                                .font(.system(size: 13))
                                .foregroundColor(.campusGray)

                            HStack(spacing: 8) {
                                Text(student.major)
                                    .font(.system(size: 12))
                                    .foregroundColor(.campusGray)
                                Text("·").foregroundColor(.campusGray)
                                Text(student.year)
                                    .font(.system(size: 12))
                                    .foregroundColor(.campusGray)
                            }

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(student.communities, id: \.self) { community in
                                        Text(community)
                                            .font(.system(size: 11, weight: .semibold))
                                            .foregroundColor(.campusBlue)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color.campusBlue.opacity(0.09))
                                            .cornerRadius(100)
                                    }
                                }
                            }
                            .padding(.top, 4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 50)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)

                        // STATS
                        HStack(spacing: 0) {
                            friendStat(value: "142", label: "Amigos")
                            Divider().frame(height: 40).background(Color.campusBorder)
                            friendStat(value: "8", label: "Logros")
                            Divider().frame(height: 40).background(Color.campusBorder)
                            friendStat(value: "3", label: "Comunidades")
                        }
                        .padding(.vertical, 16)
                        .background(Color.campusCard)
                        .cornerRadius(14)
                        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)

                        // BOTONES
                        HStack(spacing: 12) {
                            Button {} label: {
                                Text("Agregar amigos")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 11)
                                    .background(Color.campusBlue)
                                    .cornerRadius(10)
                            }

                            Button {} label: {
                                Text("Editar perfil")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.campusText)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 11)
                                    .background(Color.campusCard)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.campusBorder, lineWidth: 1.5))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)

                        // WALLET BUTTON
                        NavigationLink(destination: WalletView()) {
                            HStack(spacing: 10) {
                                Image(systemName: "creditcard.fill")
                                    .font(.system(size: 15))
                                    .foregroundColor(.campusBlue)
                                Text("Mi Wallet — Boletos y Cupones")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.campusText)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(.campusGray)
                            }
                            .padding(14)
                            .background(Color.campusCard)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)

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

                        profileContent
                    }
                }
            }
        }
    }

    @ViewBuilder
    var profileContent: some View {
        if selectedTab == "Actividad" {
            activityTab
        } else {
            logrosTab
        }
    }

    var activityTab: some View {
        VStack(spacing: 0) {
            ForEach([
                ("📝", "Publicaste en Tech & AI", "¿Alguien más usando Claude para sus tareas? 🤖", "hace 1h"),
                ("🏅", "Conseguiste un logro", "Investigador de Campo — UNICEF", "hace 2 días"),
                ("📝", "Publicaste en Nightlife", "FURIA estuvo increíble anoche 🔥", "hace 3 días"),
                ("🏷️", "Recomendaste un cupón", "20% off en Tacos La Neta — úsenlo!", "hace 5 días"),
                ("📝", "Publicaste en FSU", "Recordatorio: examen parcial el viernes 📚", "hace 1 semana"),
                ("👥", "Te uniste a Fitness", "Nueva comunidad", "hace 2 semanas")
            ], id: \.2) { emoji, action, content, time in
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.campusBlue.opacity(0.08))
                                .frame(width: 36, height: 36)
                            Text(emoji).font(.system(size: 16))
                        }
                        VStack(alignment: .leading, spacing: 3) {
                            Text(action)
                                .font(.system(size: 12))
                                .foregroundColor(.campusGray)
                            Text(content)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.campusText)
                                .lineLimit(2)
                        }
                        Spacer()
                        Text(time)
                            .font(.system(size: 11))
                            .foregroundColor(.campusGray.opacity(0.7))
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)

                    Divider()
                        .background(Color.campusBorder)
                        .padding(.horizontal, 20)
                }
            }
        }
    }

    var logrosTab: some View {
        VStack(spacing: 12) {
            ForEach([
                ("🏅", "Investigador de Campo", "UNICEF", "Participó en research sobre nutrición en África", "Mar 2026"),
                ("🌱", "Voluntario Verde", "WWF Panamá", "Campaña de reforestación universitaria", "Feb 2026"),
                ("💡", "Innovador Campus", "Campus Life", "Ganador del Hackathon universitario 2025", "Dic 2025")
            ], id: \.1) { emoji, title, org, desc, date in
                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(Color.yellow.opacity(0.12))
                            .frame(width: 54, height: 54)
                        Text(emoji).font(.system(size: 26))
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.campusText)
                        Text(org)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.campusBlue)
                        Text(desc)
                            .font(.system(size: 12))
                            .foregroundColor(.campusGray)
                            .lineLimit(2)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(date)
                            .font(.system(size: 10))
                            .foregroundColor(.campusGray)
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.campusBlue)
                            .font(.system(size: 14))
                    }
                }
                .padding(14)
                .background(Color.campusCard)
                .cornerRadius(14)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.yellow.opacity(0.2), lineWidth: 1)
                )
            }
        }
        .padding(16)
    }

    func friendStat(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.campusText)
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.campusGray)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileView()
}
