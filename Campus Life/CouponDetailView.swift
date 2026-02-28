import SwiftUI

struct CouponDetailView: View {
    let coupon: Coupon
    let student = Student.sampleStudent
    @State private var isDownloaded = false
    @State private var showQR = false
    @State private var selectedImageTab = "Local"

    let imageTabs = ["Local", "Menú"]

    var body: some View {
        ZStack {
            Color.campusBG.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // BANNER DEL LOCAL
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(
                            colors: [Color.orange.opacity(0.7), Color.red.opacity(0.5)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 200)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(coupon.localImages, id: \.self) { img in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                        Text(img)
                                            .font(.system(size: 36))
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        }

                        HStack {
                            Spacer()
                            Text(coupon.discount)
                                .font(.system(size: 18, weight: .black))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.orange)
                                .cornerRadius(100)
                                .padding(16)
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }

                    VStack(alignment: .leading, spacing: 20) {

                        // NOMBRE Y CATEGORÍA
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(spacing: 10) {
                                Text(coupon.businessEmoji)
                                    .font(.system(size: 28))
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(coupon.businessName)
                                        .font(.system(size: 22, weight: .heavy))
                                        .foregroundColor(.campusText)
                                    Text(coupon.businessCategory)
                                        .font(.system(size: 13))
                                        .foregroundColor(.campusGray)
                                }
                            }
                            Text(coupon.description)
                                .font(.system(size: 14))
                                .foregroundColor(.campusGray)
                                .lineSpacing(4)
                                .padding(.top, 4)
                        }

                        // INFO DEL LOCAL
                        VStack(spacing: 10) {
                            infoRow(icon: "mappin.circle.fill", text: coupon.location, color: .red)
                            infoRow(icon: "calendar", text: "Válido hasta: \(coupon.validUntil)", color: .campusBlue)
                            infoRow(icon: "globe", text: coupon.websiteURL, color: .campusBlue)

                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color.pink.opacity(0.12))
                                        .frame(width: 32, height: 32)
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.pink)
                                        .font(.system(size: 13))
                                }
                                Text(coupon.instagramHandle)
                                    .font(.system(size: 14))
                                    .foregroundColor(.pink)
                                Spacer()
                                Image(systemName: "arrow.up.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(.campusGray)
                            }
                        }
                        .padding(16)
                        .background(Color.campusCard)
                        .cornerRadius(14)
                        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)

                        // GALERÍA
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 8) {
                                ForEach(imageTabs, id: \.self) { tab in
                                    Button {
                                        selectedImageTab = tab
                                    } label: {
                                        Text(tab)
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundColor(selectedImageTab == tab ? .white : .campusText)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 7)
                                            .background(selectedImageTab == tab ? Color.campusBlue : Color.campusBG)
                                            .cornerRadius(100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 100)
                                                    .stroke(selectedImageTab == tab ? Color.campusBlue : Color.campusBorder, lineWidth: 1.5)
                                            )
                                    }
                                }
                            }

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(selectedImageTab == "Local" ? coupon.localImages : coupon.menuImages, id: \.self) { img in
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.campusBG)
                                                .frame(width: 100, height: 100)
                                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.campusBorder, lineWidth: 1))
                                            Text(img)
                                                .font(.system(size: 44))
                                        }
                                    }
                                }
                            }
                        }

                        // MAPA
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Ubicación")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.campusText)

                            ZStack {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.campusCard)
                                    .frame(height: 140)
                                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)

                                VStack(spacing: 8) {
                                    Image(systemName: "map.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.campusBlue)
                                    Text(coupon.location)
                                        .font(.system(size: 13))
                                        .foregroundColor(.campusGray)
                                    Text("Abrir en Maps")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.campusBlue)
                                }
                            }
                        }

                        // TÉRMINOS
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Términos y condiciones")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.campusText)
                            Text(coupon.termsAndConditions)
                                .font(.system(size: 12))
                                .foregroundColor(.campusGray)
                                .lineSpacing(4)
                        }
                        .padding(14)
                        .background(Color.campusBG)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.campusBorder, lineWidth: 1))

                        // BOTÓN DESCARGAR
                        Button {
                            isDownloaded = true
                            showQR = true
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: isDownloaded ? "checkmark.circle.fill" : "arrow.down.circle.fill")
                                    .font(.system(size: 18))
                                Text(isDownloaded ? "Cupón descargado" : "Descargar cupón")
                                    .font(.system(size: 16, weight: .bold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(isDownloaded ? Color.green : Color.orange)
                            .cornerRadius(14)
                        }
                        .padding(.bottom, 30)
                    }
                    .padding(20)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showQR) {
            CouponQRView(coupon: coupon, student: student)
        }
    }

    func infoRow(icon: String, text: String, color: Color) -> some View {
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
        CouponDetailView(coupon: Coupon.sampleCoupons[0])
    }
}
