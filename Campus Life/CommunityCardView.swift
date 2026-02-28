import SwiftUI

struct CommunityCardView: View {
    let community: Community
    @State private var joined: Bool

    init(community: Community) {
        self.community = community
        self._joined = State(initialValue: community.isJoined)
    }

    var body: some View {
        HStack(spacing: 14) {

            // ÍCONO
            ZStack {
                Circle()
                    .fill(Color.campusBlue.opacity(0.09))
                    .frame(width: 52, height: 52)
                Text(community.emoji)
                    .font(.system(size: 24))
            }

            // INFO
            VStack(alignment: .leading, spacing: 4) {
                Text(community.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.campusText)

                Text(community.description)
                    .font(.system(size: 12))
                    .foregroundColor(.campusGray)
                    .lineLimit(1)

                Text("\(community.members) miembros")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.campusGray.opacity(0.8))
            }

            Spacer()

            // BOTÓN SEGUIR
            Button {
                joined.toggle()
            } label: {
                Text(joined ? "Siguiendo" : "Seguir")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(joined ? .campusGray : .white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(joined ? Color.campusBG : Color.campusBlue)
                    .cornerRadius(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(joined ? Color.campusBorder : Color.campusBlue, lineWidth: 1.5)
                    )
            }
        }
        .padding(14)
        .background(Color.campusCard)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 3)
    }
}

#Preview {
    CommunityCardView(community: Community.sampleCommunities[0])
        .padding()
        .background(Color.campusBG)
}
