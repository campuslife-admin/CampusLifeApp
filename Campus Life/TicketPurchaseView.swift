import SwiftUI

struct TicketPurchaseView: View {
    let event: Event
    let ticketCount: Int
    let student = Student.sampleStudent
    @Environment(\.dismiss) var dismiss
    @State private var currentStep = 1
    @State private var cardNumber = ""
    @State private var cardName = ""
    @State private var expiry = ""
    @State private var cvv = ""
    @State private var isProcessing = false

    var totalPrice: Double {
        event.price * Double(ticketCount)
    }

    var body: some View {
        ZStack {
            Color.campusCard.ignoresSafeArea()

            VStack(spacing: 0) {

                // HANDLE + HEADER
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.campusBorder)
                        .frame(width: 40, height: 4)
                        .padding(.top, 12)

                    // PASOS
                    HStack(spacing: 8) {
                        ForEach(1...3, id: \.self) { step in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(step <= currentStep ? Color.campusBlue : Color.campusBorder)
                                .frame(height: 3)
                        }
                    }
                    .padding(.horizontal, 20)

                    Text(stepTitle)
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundColor(.campusText)
                }
                .padding(.bottom, 20)

                Divider().background(Color.campusBorder)

                // CONTENIDO
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        if currentStep == 1 {
                            summaryStep
                        } else if currentStep == 2 {
                            paymentStep
                        } else {
                            confirmationStep
                        }
                    }
                }

                // BOTÓN
                if currentStep < 3 {
                    Button {
                        if currentStep == 2 {
                            isProcessing = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                isProcessing = false
                                currentStep = 3
                            }
                        } else {
                            currentStep += 1
                        }
                    } label: {
                        HStack(spacing: 10) {
                            if isProcessing {
                                ProgressView().tint(.white)
                                Text("Procesando pago...")
                            } else {
                                Text(currentStep == 1 ? "Continuar al pago" : "Pagar $\(String(format: "%.0f", totalPrice))")
                                Image(systemName: currentStep == 1 ? "arrow.right" : "lock.fill")
                            }
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(isProcessing ? Color.campusGray : Color.campusBlue)
                        .cornerRadius(14)
                    }
                    .disabled(isProcessing || (currentStep == 2 && !isFormValid))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
        }
    }

    var stepTitle: String {
        switch currentStep {
        case 1: return "Resumen de compra"
        case 2: return "Datos de pago"
        case 3: return "¡Compra exitosa! 🎉"
        default: return ""
        }
    }

    var isFormValid: Bool {
        !cardNumber.isEmpty && !cardName.isEmpty && !expiry.isEmpty && !cvv.isEmpty
    }

    // PASO 1 — RESUMEN
    var summaryStep: some View {
        VStack(spacing: 16) {

            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(
                            colors: [Color.campusBlue, Color.campusBlue.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 60, height: 60)
                    Text(event.emoji).font(.system(size: 28))
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.campusText)
                        .lineLimit(2)
                    Text(event.date)
                        .font(.system(size: 12))
                        .foregroundColor(.campusGray)
                    Text(event.location)
                        .font(.system(size: 12))
                        .foregroundColor(.campusGray)
                }
                Spacer()
            }
            .padding(16)
            .background(Color.campusBG)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.campusBorder, lineWidth: 1))

            VStack(spacing: 10) {
                priceRow(label: "Precio por boleto", value: "$\(String(format: "%.2f", event.price))")
                priceRow(label: "Cantidad", value: "\(ticketCount)")
                priceRow(label: "Cargo por servicio", value: "$\(String(format: "%.2f", totalPrice * 0.05))")

                Divider().background(Color.campusBorder)

                HStack {
                    Text("Total")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.campusText)
                    Spacer()
                    Text("$\(String(format: "%.2f", totalPrice * 1.05))")
                        .font(.system(size: 18, weight: .black))
                        .foregroundColor(.campusBlue)
                }
            }
            .padding(16)
            .background(Color.campusBG)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.campusBorder, lineWidth: 1))

            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.campusBlue.opacity(0.1))
                        .frame(width: 40, height: 40)
                    Text(student.avatarEmoji).font(.system(size: 20))
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(student.name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.campusText)
                    Text("Estudiante verificado ✓")
                        .font(.system(size: 12))
                        .foregroundColor(.green)
                }
                Spacer()
            }
            .padding(14)
            .background(Color.campusBG)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.campusBorder, lineWidth: 1))
        }
        .padding(20)
    }

    // PASO 2 — PAGO
    var paymentStep: some View {
        VStack(spacing: 16) {

            HStack(spacing: 8) {
                ForEach(["💳 Tarjeta", "📱 Yappy", "🏦 ACH"], id: \.self) { method in
                    Text(method)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(method == "💳 Tarjeta" ? .white : .campusText)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(method == "💳 Tarjeta" ? Color.campusBlue : Color.campusBG)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(method == "💳 Tarjeta" ? Color.campusBlue : Color.campusBorder, lineWidth: 1.5)
                        )
                }
            }

            VStack(spacing: 12) {
                paymentField(placeholder: "Número de tarjeta", text: $cardNumber, keyboardType: .numberPad)
                paymentField(placeholder: "Nombre en la tarjeta", text: $cardName, keyboardType: .default)
                HStack(spacing: 12) {
                    paymentField(placeholder: "MM/AA", text: $expiry, keyboardType: .numberPad)
                    paymentField(placeholder: "CVV", text: $cvv, keyboardType: .numberPad)
                }
            }

            HStack(spacing: 8) {
                Image(systemName: "lock.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.green)
                Text("Pago seguro encriptado con SSL")
                    .font(.system(size: 12))
                    .foregroundColor(.campusGray)
            }
            .padding(12)
            .background(Color.green.opacity(0.07))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green.opacity(0.2), lineWidth: 1))

            HStack {
                Text("Total a pagar")
                    .font(.system(size: 14))
                    .foregroundColor(.campusGray)
                Spacer()
                Text("$\(String(format: "%.2f", totalPrice * 1.05))")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.campusText)
            }
            .padding(14)
            .background(Color.campusBG)
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.campusBorder, lineWidth: 1))
        }
        .padding(20)
    }

    // PASO 3 — CONFIRMACIÓN
    var confirmationStep: some View {
        VStack(spacing: 24) {

            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.1))
                    .frame(width: 100, height: 100)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
            }
            .padding(.top, 20)

            VStack(spacing: 8) {
                Text("¡Compra exitosa!")
                    .font(.system(size: 24, weight: .heavy))
                    .foregroundColor(.campusText)
                Text("Tu boleto ya está en tu Wallet")
                    .font(.system(size: 14))
                    .foregroundColor(.campusGray)
            }

            // BOLETO
            VStack(spacing: 0) {
                VStack(spacing: 12) {
                    Text(event.emoji).font(.system(size: 40))
                    Text(event.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.campusText)
                        .multilineTextAlignment(.center)
                    Text(event.date)
                        .font(.system(size: 13))
                        .foregroundColor(.campusGray)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.campusBG)

                HStack(spacing: 4) {
                    ForEach(0..<20) { _ in
                        Rectangle()
                            .fill(Color.campusBorder)
                            .frame(width: 8, height: 1)
                    }
                }

                VStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.campusText)
                            .frame(width: 130, height: 130)
                        Image(systemName: "qrcode")
                            .font(.system(size: 100))
                            .foregroundColor(.white)
                    }
                    Text("ID: \(student.studentID)")
                        .font(.system(size: 11))
                        .foregroundColor(.campusGray)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.campusCard)
            }
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.campusBorder, lineWidth: 1.5)
            )
            .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 6)
            .padding(.horizontal, 20)

            Button {
                dismiss()
            } label: {
                Text("Ver mi Wallet")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.campusBlue)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
    }

    func priceRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.campusGray)
            Spacer()
            Text(value)
                .font(.system(size: 14))
                .foregroundColor(.campusText)
        }
    }

    func paymentField(placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType) -> some View {
        TextField(placeholder, text: text)
            .keyboardType(keyboardType)
            .foregroundColor(.campusText)
            .padding(14)
            .background(Color.campusBG)
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.campusBorder, lineWidth: 1.5))
    }
}

#Preview {
    TicketPurchaseView(event: Event.sampleEvents[0], ticketCount: 2)
}
