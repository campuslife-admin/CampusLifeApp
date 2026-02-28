import SwiftUI

struct ContentView: View {

    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            MainTabView()
        } else {
            NavigationStack {
                ZStack {
                    // Splash en azul campus — momento de marca bold
                    Color.campusBlue.ignoresSafeArea()

                    VStack(spacing: 32) {

                        Spacer()

                        VStack(spacing: 16) {
                            Text("🎓")
                                .font(.system(size: 72))

                            VStack(spacing: 8) {
                                Text("Campus Life")
                                    .font(.system(size: 34, weight: .heavy))
                                    .foregroundColor(.white)

                                Text("Vive tu mejor experiencia universitaria")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white.opacity(0.75))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 32)
                            }
                        }

                        Spacer()

                        VStack(spacing: 12) {
                            NavigationLink(destination: RegisterView(isLoggedIn: $isLoggedIn)) {
                                Text("Únete a Campus")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.campusBlue)
                                    .fontWeight(.bold)
                                    .cornerRadius(14)
                            }

                            NavigationLink(destination: LoginView()) {
                                Text("Ya tengo cuenta")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white.opacity(0.18))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .cornerRadius(14)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
