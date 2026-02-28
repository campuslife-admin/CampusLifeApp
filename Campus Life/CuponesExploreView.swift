import SwiftUI

struct CuponesExploreView: View {
    let searchText: String
    @State private var selectedCategoria = "Todos"

    let categorias = ["Todos", "🍔 Comida", "☕ Cafés", "👟 Ropa", "🏋️ Fitness"]

    var filteredCoupons: [Coupon] {
        Coupon.sampleCoupons.filter { coupon in
            searchText.isEmpty ||
            coupon.businessName.localizedCaseInsensitiveContains(searchText) ||
            coupon.businessCategory.localizedCaseInsensitiveContains(searchText) ||
            coupon.location.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categorias, id: \.self) { cat in
                            Button {
                                selectedCategoria = cat
                            } label: {
                                Text(cat)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(selectedCategoria == cat ? .white : .campusText)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(selectedCategoria == cat ? Color.campusBlue : Color.campusCard)
                                    .cornerRadius(100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100)
                                            .stroke(selectedCategoria == cat ? Color.campusBlue : Color.campusBorder, lineWidth: 1.5)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 16)

                Divider().background(Color.campusBorder)

                if filteredCoupons.isEmpty {
                    VStack(spacing: 12) {
                        Text("🔍").font(.system(size: 40)).padding(.top, 40)
                        Text("Sin resultados")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.campusText)
                        Text("No encontramos cupones para \"\(searchText)\"")
                            .font(.system(size: 14))
                            .foregroundColor(.campusGray)
                            .multilineTextAlignment(.center)
                    }
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredCoupons) { coupon in
                            NavigationLink(destination: CouponDetailView(coupon: coupon)) {
                                HStack(spacing: 14) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.orange.opacity(0.1))
                                            .frame(width: 56, height: 56)
                                        Text(coupon.businessEmoji)
                                            .font(.system(size: 26))
                                    }
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(coupon.businessName)
                                            .font(.system(size: 15, weight: .bold))
                                            .foregroundColor(.campusText)
                                        Text(coupon.businessCategory)
                                            .font(.system(size: 12))
                                            .foregroundColor(.campusGray)
                                        Text(coupon.location)
                                            .font(.system(size: 11))
                                            .foregroundColor(.campusGray.opacity(0.8))
                                    }
                                    Spacer()
                                    Text(coupon.discount)
                                        .font(.system(size: 16, weight: .black))
                                        .foregroundColor(.orange)
                                }
                                .padding(14)
                                .background(Color.campusCard)
                                .cornerRadius(14)
                                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

#Preview {
    NavigationStack { CuponesExploreView(searchText: "") }
}
