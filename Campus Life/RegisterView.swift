import SwiftUI

struct RegisterView: View {

    @State private var currentStep = 1
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var hasUniversityEmail = false
    @State private var selectedUniversity = ""
    @Binding var isLoggedIn: Bool

    let universities = [
        "Florida State University",
        "Universidad Tecnológica de Panamá",
        "Universidad de Panamá",
        "Universidad Santa María La Antigua",
        "Universidad Latina de Panamá",
        "Universidad Interamericana de Panamá"
    ]

    var body: some View {
        ZStack {
            Color.campusBG.ignoresSafeArea()

            VStack(spacing: 28) {

                // BARRA DE PROGRESO
                HStack(spacing: 8) {
                    ForEach(1...3, id: \.self) { step in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(step <= currentStep ? Color.campusBlue : Color.campusBorder)
                            .frame(height: 4)
                    }
                }
                .padding(.horizontal)

                if currentStep == 1 {
                    stepOne
                } else if currentStep == 2 {
                    stepTwo
                } else {
                    stepThree
                }
            }
            .padding(.top, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // PASO 1 — Datos personales
    var stepOne: some View {
        VStack(spacing: 20) {

            VStack(alignment: .leading, spacing: 6) {
                Text("Crea tu cuenta")
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundColor(.campusText)
                Text("Paso 1 de 3 — Datos personales")
                    .font(.system(size: 14))
                    .foregroundColor(.campusGray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            VStack(spacing: 14) {
                campusField("Tu nombre completo", text: $name)
                campusField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                campusSecureField("Contraseña", text: $password)
            }
            .padding(.horizontal)

            Button("Continuar") {
                currentStep = 2
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(name.isEmpty || email.isEmpty || password.isEmpty ? Color.campusBorder : Color.campusBlue)
            .foregroundColor(name.isEmpty || email.isEmpty || password.isEmpty ? Color.campusGray : .white)
            .fontWeight(.bold)
            .cornerRadius(14)
            .padding(.horizontal)
            .disabled(name.isEmpty || email.isEmpty || password.isEmpty)
        }
    }

    // PASO 2 — Universidad
    var stepTwo: some View {
        VStack(spacing: 20) {

            VStack(alignment: .leading, spacing: 6) {
                Text("Tu universidad")
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundColor(.campusText)
                Text("Paso 2 de 3 — Verificación")
                    .font(.system(size: 14))
                    .foregroundColor(.campusGray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            VStack(spacing: 12) {
                // OPCIÓN 1
                Button {
                    hasUniversityEmail = true
                    currentStep = 3
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tengo email universitario")
                                .fontWeight(.semibold)
                                .foregroundColor(.campusText)
                            Text("Verificación instantánea")
                                .font(.caption)
                                .foregroundColor(.campusGray)
                        }
                        Spacer()
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.campusBlue)
                            .font(.title2)
                    }
                    .padding()
                    .background(Color.campusCard)
                    .cornerRadius(14)
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.campusBorder, lineWidth: 1.5))
                }

                // OPCIÓN 2
                Button {
                    hasUniversityEmail = false
                    currentStep = 3
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("No tengo email universitario")
                                .fontWeight(.semibold)
                                .foregroundColor(.campusText)
                            Text("Solicitud manual de verificación")
                                .font(.caption)
                                .foregroundColor(.campusGray)
                        }
                        Spacer()
                        Image(systemName: "envelope.badge.fill")
                            .foregroundColor(.orange)
                            .font(.title2)
                    }
                    .padding()
                    .background(Color.campusCard)
                    .cornerRadius(14)
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.campusBorder, lineWidth: 1.5))
                }
            }
            .padding(.horizontal)
        }
    }

    // PASO 3 — Seleccionar universidad
    var stepThree: some View {
        VStack(spacing: 20) {

            VStack(alignment: .leading, spacing: 6) {
                Text("¿Dónde estudias?")
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundColor(.campusText)
                Text("Paso 3 de 3 — Tu universidad")
                    .font(.system(size: 14))
                    .foregroundColor(.campusGray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(universities, id: \.self) { university in
                        Button {
                            selectedUniversity = university
                        } label: {
                            HStack {
                                Text(university)
                                    .foregroundColor(.campusText)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                if selectedUniversity == university {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.campusBlue)
                                }
                            }
                            .padding()
                            .background(selectedUniversity == university ? Color.campusBlue.opacity(0.07) : Color.campusCard)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selectedUniversity == university ? Color.campusBlue : Color.campusBorder, lineWidth: 1.5)
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }

            Button("Crear mi cuenta") {
                isLoggedIn = true
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(selectedUniversity.isEmpty ? Color.campusBorder : Color.campusBlue)
            .foregroundColor(selectedUniversity.isEmpty ? Color.campusGray : .white)
            .fontWeight(.bold)
            .cornerRadius(14)
            .padding(.horizontal)
            .disabled(selectedUniversity.isEmpty)
        }
    }
}

#Preview {
    NavigationStack { RegisterView(isLoggedIn: .constant(false)) }
}
