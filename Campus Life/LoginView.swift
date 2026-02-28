import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            Color.campusBG.ignoresSafeArea()

            VStack(spacing: 28) {

                VStack(alignment: .leading, spacing: 6) {
                    Text("Bienvenido de vuelta")
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundColor(.campusText)
                    Text("Explora lo que tenemos para ti")
                        .font(.system(size: 15))
                        .foregroundColor(.campusGray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                VStack(spacing: 14) {
                    campusField("Tu email universitario", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                    campusSecureField("Contraseña", text: $password)
                }
                .padding(.horizontal)

                Button("Entrar al Campus") {
                    print("Login: \(email)")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.campusBlue)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .cornerRadius(14)
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Helpers de campo compartidos
func campusField(_ placeholder: String, text: Binding<String>) -> some View {
    TextField(placeholder, text: text)
        .foregroundColor(.campusText)
        .padding()
        .background(Color.campusCard)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.campusBorder, lineWidth: 1.5))
}

func campusSecureField(_ placeholder: String, text: Binding<String>) -> some View {
    SecureField(placeholder, text: text)
        .foregroundColor(.campusText)
        .padding()
        .background(Color.campusCard)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.campusBorder, lineWidth: 1.5))
}

#Preview {
    NavigationStack { LoginView() }
}
