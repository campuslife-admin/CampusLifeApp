import SwiftUI

struct DigitalIDView: View {
    let student: Student

    var body: some View {
        ZStack {
            Color.campusBG.ignoresSafeArea()

            VStack(spacing: 24) {

                Text("Tu ID Campus Life")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(.campusText)

                // CARD — mantiene gradiente azul (es la tarjeta de identidad)
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(LinearGradient(
                            colors: [Color.campusBlue, Color.campusBlue.opacity(0.75)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 320, height: 420)
                        .shadow(color: Color.campusBlue.opacity(0.35), radius: 24, x: 0, y: 12)

                    VStack(spacing: 16) {

                        Text("🎓")
                            .font(.system(size: 40))

                        Text("Campus Life")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white.opacity(0.85))
                            .tracking(2)

                        Divider()
                            .background(Color.white.opacity(0.3))
                            .padding(.horizontal, 30)

                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.18))
                                .frame(width: 80, height: 80)
                            Text(student.avatarEmoji)
                                .font(.system(size: 40))
                        }

                        VStack(spacing: 4) {
                            Text(student.name)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            Text(student.university)
                                .font(.system(size: 13))
                                .foregroundColor(.white.opacity(0.75))
                            Text(student.major)
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.55))
                        }

                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .frame(width: 110, height: 110)
                            Image(systemName: "qrcode")
                                .font(.system(size: 80))
                                .foregroundColor(.campusBlue)
                        }

                        Text("ID: \(student.studentID)")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.white.opacity(0.65))
                            .tracking(1)
                    }
                }

                // ESTADO
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                    Text("Estudiante Verificado")
                        .font(.system(size: 14))
                        .foregroundColor(.campusGray)
                }

                // BOTONES
                HStack(spacing: 12) {
                    Button {} label: {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.down")
                            Text("Guardar")
                        }
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.campusText)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.campusCard)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.campusBorder, lineWidth: 1.5))
                    }

                    Button {} label: {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                            Text("Compartir")
                        }
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.campusBlue)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DigitalIDView(student: Student.sampleStudent)
    }
}
