//
//  Post.swift
//  Campus Life
//
//  Created by Richard Edmundo on 02/24/26.
//

import Foundation

struct Post: Identifiable {
    let id = UUID()
    let community: String
    let communityEmoji: String
    let author: String
    let content: String
    let imageURL: String?
    let likes: Int
    let comments: Int
    let reposts: Int
    let timeAgo: String
    let postType: PostType
}

enum PostType {
    case text
    case image
    case poll
}

// DATOS DE PRUEBA
extension Post {
    static let samplePosts: [Post] = [
        Post(
            community: "Nightlife",
            communityEmoji: "🌙",
            author: "Campus Life",
            content: "Esta fiesta está de locos esta noche! No te la puedes perder 🔥",
            imageURL: nil,
            likes: 124,
            comments: 18,
            reposts: 7,
            timeAgo: "hace 2h",
            postType: .text
        ),
        Post(
            community: "Fitness",
            communityEmoji: "🏋️",
            author: "Campus Life",
            content: "Rutina de lunes lista para ti 💪 Sin excusas, hoy se entrena.",
            imageURL: nil,
            likes: 89,
            comments: 12,
            reposts: 4,
            timeAgo: "hace 3h",
            postType: .text
        ),
        Post(
            community: "Tech & AI",
            communityEmoji: "🤖",
            author: "Campus Life",
            content: "¿Usas inteligencia artificial para estudiar? Los resultados te van a sorprender.",
            imageURL: nil,
            likes: 201,
            comments: 45,
            reposts: 23,
            timeAgo: "hace 5h",
            postType: .poll
        ),
        Post(
            community: "Trips",
            communityEmoji: "✈️",
            author: "Campus Life",
            content: "Spring break se acerca 🌊 ¿A dónde nos vamos este año?",
            imageURL: nil,
            likes: 312,
            comments: 67,
            reposts: 31,
            timeAgo: "hace 6h",
            postType: .text
        ),
        Post(
            community: "Foodies",
            communityEmoji: "🍔",
            author: "Campus Life",
            content: "Nuevo restaurante cerca del campus con 20% de descuento para estudiantes 👀",
            imageURL: nil,
            likes: 445,
            comments: 89,
            reposts: 56,
            timeAgo: "hace 8h",
            postType: .text
        )
    ]
}
