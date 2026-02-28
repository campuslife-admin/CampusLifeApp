import SwiftUI

struct CuponesTabView: View {
    @State private var selectedCategoria = "Todos"
    @State private var searchText = ""

    let categorias = ["Todos", "🍔 Comida", "☕ Cafés", "👟 Ropa", "🏋️ Fitness", "🎭 Entretenimiento"]

    var filteredCoupons: [Coupon] {
        Coupon.sampleCoupons.filter { coupon in
            searchText.isEmpty ||
            coupon.businessName.localizedCaseInsensitiveContains(searchText) ||
            coupon.businessCategory.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.campusBG.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // HEADER
                        HStack {
                            Text("Cupones")
                                .font(.system(size: 28, weight: .heavy))
                                .foregroundColor(.campusText)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 14)

                        // SEARCH BAR
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.campusGray)
                            TextField("Buscar cupones o negocios...", text: $searchText)
                                .foregroundColor(.campusText)
                            if !searchText.isEmpty {
                                Button {
                                    searchText = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.campusGray)
                                }
                            }
                        }
                        .padding(13)
                        .background(Color.campusCard)
                        .cornerRadius(13)
                        .overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.campusBorder, lineWidth: 1.5))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)

                        // CATEGORÍAS
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
                                            .padding(.vertical, 9)
                                            .background(selectedCategoria == cat ? Color.campusBlue : Color.campusCard)
                                            .cornerRadius(100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 100)
                                                    .stroke(selectedCategoria == cat ? Color.campusBlue : Color.campusBorder, lineWidth: 1.5)
                                            )
                                            .shadow(
                                                color: selectedCategoria == cat ? Color.campusBlue.opacity(0.25) : .clear,
                                                radius: 8, x: 0, y: 3
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 2)
                        }
                        .padding(.bottom, 16)

                        Divider().background(Color.campusBorder)

                        // CUPONES
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
                                                    .frame(width: 60, height: 60)
                                                Text(coupon.businessEmoji)
                                                    .font(.system(size: 28))
                                            }

                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(coupon.businessName)
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(.campusText)
                                                Text(coupon.businessCategory)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.campusGray)
                                                HStack(spacing: 4) {
                                                    Image(systemName: "mappin.circle.fill")
                                                        .font(.system(size: 10))
                                                        .foregroundColor(.campusGray)
                                                    Text(coupon.location)
                                                        .font(.system(size: 11))
                                                        .foregroundColor(.campusGray)
                                                }
                                            }

                                            Spacer()

                                            VStack(alignment: .trailing, spacing: 6) {
                                                Text(coupon.discount)
                                                    .font(.system(size: 18, weight: .black))
                                                    .foregroundColor(.orange)
                                                Text("Ver cupón")
                                                    .font(.system(size: 11, weight: .semibold))
                                                    .foregroundColor(.campusBlue)
                                            }
                                        }
                                        .padding(14)
                                        .background(Color.campusCard)
                                        .cornerRadius(16)
                                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 3)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CuponesTabView()
}
