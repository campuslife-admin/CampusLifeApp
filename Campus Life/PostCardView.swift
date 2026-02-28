//
//  PostCardView.swift
//  Campus Life
//
//  Redesigned — Campus Life Brand: blanco, #004AAD, minimalista Apple
//

import SwiftUI

struct PostCardView: View {
    let post: Post
    @State private var isLiked = false
    @State private var isBookmarked = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── HEADER ────────────────────────────────────────────────
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.campusBlue.opacity(0.09))
                        .frame(width: 42, height: 42)
                    Text(post.communityEmoji)
                        .font(.system(size: 19))
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(post.community)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.campusText)
                    Text(post.timeAgo)
                        .font(.system(size: 12))
                        .foregroundColor(.campusGray)
                }

                Spacer()

                Image(systemName: "ellipsis")
                    .foregroundColor(.campusGray)
                    .font(.system(size: 16))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)

            // ── CONTENIDO ─────────────────────────────────────────────
            Text(post.content)
                .font(.system(size: 15))
                .foregroundColor(.campusText)
                .lineSpacing(5)
                .padding(.horizontal, 16)
                .padding(.bottom, 14)

            // ── ENCUESTA ──────────────────────────────────────────────
            if post.postType == .poll {
                VStack(spacing: 8) {
                    pollOption(text: "Sí, la uso siempre", percentage: 67, color: .campusBlue)
                    pollOption(text: "No, prefiero estudiar solo", percentage: 33, color: .campusGray)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 14)
            }

            // ── DIVIDER ───────────────────────────────────────────────
            Divider()
                .background(Color.campusBorder)

            // ── ACCIONES ──────────────────────────────────────────────
            HStack(spacing: 0) {
                actionButton(
                    icon: isLiked ? "heart.fill" : "heart",
                    count: post.likes + (isLiked ? 1 : 0),
                    color: isLiked ? .red : .campusGray
                ) {
                    withAnimation(.easeInOut(duration: 0.15)) { isLiked.toggle() }
                }

                actionButton(
                    icon: "bubble.left",
                    count: post.comments,
                    color: .campusGray
                ) {}

                actionButton(
                    icon: "arrow.2.squarepath",
                    count: post.reposts,
                    color: .campusGray
                ) {}

                Spacer()

                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { isBookmarked.toggle() }
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(isBookmarked ? .campusBlue : .campusGray)
                        .font(.system(size: 16))
                        .padding(.trailing, 16)
                        .padding(.vertical, 12)
                }
            }
        }
        .background(Color.campusCard)
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.06), radius: 14, x: 0, y: 4)
    }

    // BOTÓN DE ACCIÓN
    func actionButton(icon: String, count: Int, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 15))
                Text("\(count)")
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundColor(color)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }

    // OPCIÓN DE ENCUESTA
    func pollOption(text: String, percentage: Int, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(text)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.campusText)
                Spacer()
                Text("\(percentage)%")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(color)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.campusBorder)
                        .frame(height: 5)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: geo.size.width * CGFloat(percentage) / 100, height: 5)
                }
            }
            .frame(height: 5)
        }
        .padding(12)
        .background(Color.campusBG)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.campusBorder, lineWidth: 1)
        )
    }
}

#Preview {
    PostCardView(post: Post.samplePosts[0])
        .padding()
        .background(Color.campusBG)
}
