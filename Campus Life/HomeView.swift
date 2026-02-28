//
//  HomeView.swift
//  Campus Life
//
//  Redesigned — Campus Life Brand: blanco, #004AAD, minimalista Apple
//

import SwiftUI

struct HomeView: View {
    let posts = Post.samplePosts
    @State private var selectedCommunity = "🌙 Nightlife"

    let communities = ["🌙 Nightlife", "🏋️ Fitness", "🤖 Tech & AI", "✈️ Trips", "🍔 Foodies", "⚽ Sports"]

    var body: some View {
        ZStack {
            Color.campusBG.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // ── HEADER ──────────────────────────────────────────
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Hola, Richard 👋")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.campusGray)
                            Text("Campus Life")
                                .font(.system(size: 28, weight: .heavy))
                                .foregroundColor(.campusText)
                        }

                        Spacer()

                        // Campana con badge
                        Button {} label: {
                            ZStack(alignment: .topTrailing) {
                                ZStack {
                                    Circle()
                                        .fill(Color.campusCard)
                                        .frame(width: 44, height: 44)
                                        .shadow(color: Color.black.opacity(0.07), radius: 10, x: 0, y: 3)
                                    Image(systemName: "bell")
                                        .font(.system(size: 17, weight: .medium))
                                        .foregroundColor(.campusText)
                                }
                                Circle()
                                    .fill(Color.campusBlue)
                                    .frame(width: 9, height: 9)
                                    .overlay(Circle().stroke(Color.campusBG, lineWidth: 1.5))
                                    .offset(x: 1, y: -1)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 22)

                    // ── COMUNIDADES ──────────────────────────────────────
                    VStack(alignment: .leading, spacing: 10) {
                        Text("TUS COMUNIDADES")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.campusGray)
                            .tracking(1.4)
                            .padding(.horizontal, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(communities, id: \.self) { community in
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.18)) {
                                            selectedCommunity = community
                                        }
                                    } label: {
                                        Text(community)
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundColor(selectedCommunity == community ? .white : .campusText)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 9)
                                            .background(
                                                selectedCommunity == community
                                                    ? Color.campusBlue
                                                    : Color.campusCard
                                            )
                                            .cornerRadius(100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 100)
                                                    .stroke(
                                                        selectedCommunity == community
                                                            ? Color.campusBlue
                                                            : Color.campusBorder,
                                                        lineWidth: 1.5
                                                    )
                                            )
                                            .shadow(
                                                color: selectedCommunity == community
                                                    ? Color.campusBlue.opacity(0.28)
                                                    : Color.black.opacity(0.04),
                                                radius: 8, x: 0, y: 3
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 2)
                        }
                    }
                    .padding(.bottom, 24)

                    // ── LABEL EDITORIAL ───────────────────────────────────
                    HStack(spacing: 10) {
                        Text("FEED")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.campusBlue)
                            .tracking(1.8)

                        Rectangle()
                            .fill(Color.campusBorder)
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)

                    // ── POSTS ────────────────────────────────────────────
                    LazyVStack(spacing: 14) {
                        ForEach(posts) { post in
                            PostCardView(post: post)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
