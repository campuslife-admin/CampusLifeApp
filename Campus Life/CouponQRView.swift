import SwiftUI

struct CouponQRView: View {
    let coupon: Coupon
    let student: Student
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.campusCard.ignoresSafeArea()

            VStack(spacing: 24) {

                // HANDLE
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.campusBorder)
                    .frame(width: 40, height: 4)
                    .padding(.top, 12)

                Text("Tu Cupón")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(.campusText)

                // CARD CUPÓN
                VStack(spacing: 0) {

                    // TOP — negocio
                    VStack(spacing: 8) {
                        Text(coupon.businessEmoji)
                            .font(.system(size: 44))
                        Text(coupon.businessName)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.campusText)
                        Text(coupon.discount)
                            .font(.system(size: 32, weight: .black))
                            .foregroundColor(.orange)
                        Text(coupon.description)
                            .font(.system(size: 12))
                            .foregroundColor(.campusGray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.campusBG)

                    // LÍNEA PUNTEADA
                    HStack(spacing: 4) {
                        ForEach(0..<20) { _ in
                            Rectangle()
                                .fill(Color.campusBorder)
                                .frame(width: 8, height: 1)
                        }
                    }
                    .padding(.vertical, 4)

                    // QR
                    VStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.campusText)
                                .frame(width: 160, height: 160)
                            Image(systemName: "qrcode")
                                .font(.system(size: 120))
                                .foregroundColor(.white)
                        }
                        Text("ID: \(student.studentID)")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.campusGray)
                            .tracking(1)
                    }
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.campusCard)

                    // LÍNEA PUNTEADA
                    HStack(spacing: 4) {
                        ForEach(0..<20) { _ in
                            Rectangle()
                                .fill(Color.campusBorder)
                                .frame(width: 8, height: 1)
                        }
                    }
                    .padding(.vertical, 4)

                    // BOTTOM — info del estudiante
                    HStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(Color.campusBlue.opacity(0.1))
                                .frame(width: 44, height: 44)
                            Text(student.avatarEmoji)
                                .font(.system(size: 22))
                        }
                        VStack(alignment: .leading, spacing: 3) {
                            Text(student.name)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.campusText)
                            Text(student.university)
                                .font(.system(size: 11))
                                .foregroundColor(.campusGray)
                                .lineLimit(1)
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 12))
                            Text("Verificado")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color.campusBG)
                }
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.campusBorder, lineWidth: 1.5)
                )
                .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 6)
                .padding(.horizontal, 20)

                Text("Válido hasta: \(coupon.validUntil)")
                    .font(.system(size: 13))
                    .foregroundColor(.campusGray)

                Text("Muestra este QR al cajero para aplicar tu descuento")
                    .font(.system(size: 13))
                    .foregroundColor(.campusGray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()
            }
        }
    }
}

#Preview {
    CouponQRView(coupon: Coupon.sampleCoupons[0], student: Student.sampleStudent)
}
