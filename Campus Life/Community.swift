//
//  Community.swift
//  Campus Life
//
//  Created by Richard Edmundo on 02/26/26.
//

import Foundation

struct Host: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let role: HostRole
    let university: String
}

enum HostRole {
    case admin
    case coAdmin
    case moderator

    var title: String {
        switch self {
        case .admin: return "Admin"
        case .coAdmin: return "Co-Admin"
        case .moderator: return "Moderador"
        }
    }
}

struct Community: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let description: String
    let members: Int
    let category: String
    let isJoined: Bool
    let posts: [Post]
    let hosts: [Host]
}

extension Community {
    static let sampleCommunities: [Community] = [
        Community(
            name: "Nightlife",
            emoji: "🌙",
            description: "Eventos nocturnos, fiestas universitarias y la mejor vibra del campus.",
            members: 1243,
            category: "Social",
            isJoined: true,
            posts: Post.samplePosts.filter { $0.community == "Nightlife" },
            hosts: [
                Host(name: "Carlos Méndez", emoji: "👑", role: .admin, university: "UTP"),
                Host(name: "María García", emoji: "⭐", role: .coAdmin, university: "UP"),
                Host(name: "Luis Torres", emoji: "🛡️", role: .moderator, university: "USMA")
            ]
        ),
        Community(
            name: "Fitness",
            emoji: "🏋️",
            description: "Entrena, reta y supera tus límites con la comunidad fit universitaria.",
            members: 892,
            category: "Salud",
            isJoined: true,
            posts: Post.samplePosts.filter { $0.community == "Fitness" },
            hosts: [
                Host(name: "Ana Rodríguez", emoji: "👑", role: .admin, university: "USMA"),
                Host(name: "Pedro Jiménez", emoji: "⭐", role: .coAdmin, university: "UTP")
            ]
        ),
        Community(
            name: "Tech & AI",
            emoji: "🤖",
            description: "Programación, inteligencia artificial y el futuro tecnológico.",
            members: 654,
            category: "Tecnología",
            isJoined: false,
            posts: Post.samplePosts.filter { $0.community == "Tech & AI" },
            hosts: [
                Host(name: "Diego Vargas", emoji: "👑", role: .admin, university: "UTP"),
                Host(name: "Sofia Chen", emoji: "⭐", role: .coAdmin, university: "UP"),
                Host(name: "Andrés López", emoji: "🛡️", role: .moderator, university: "USMA")
            ]
        ),
        Community(
            name: "Trips",
            emoji: "✈️",
            description: "Viajes universitarios, spring break y aventuras en grupo.",
            members: 543,
            category: "Viajes",
            isJoined: false,
            posts: [],
            hosts: [
                Host(name: "Isabella Mora", emoji: "👑", role: .admin, university: "ULatina")
            ]
        ),
        Community(
            name: "Foodies",
            emoji: "🍔",
            description: "Restaurantes, sabores y los mejores lugares cerca del campus.",
            members: 987,
            category: "Comida",
            isJoined: true,
            posts: [],
            hosts: [
                Host(name: "Camila Reyes", emoji: "👑", role: .admin, university: "USMA"),
                Host(name: "Martín Solis", emoji: "⭐", role: .coAdmin, university: "UTP")
            ]
        ),
        Community(
            name: "Sports",
            emoji: "⚽",
            description: "Fútbol, basketball, torneos y deporte universitario.",
            members: 1102,
            category: "Deportes",
            isJoined: false,
            posts: [],
            hosts: [
                Host(name: "Roberto Núñez", emoji: "👑", role: .admin, university: "UTP"),
                Host(name: "Valeria Cruz", emoji: "⭐", role: .coAdmin, university: "UP"),
                Host(name: "Felipe Arias", emoji: "🛡️", role: .moderator, university: "UInteramericana")
            ]
        ),
        Community(
            name: "Outside",
            emoji: "🌿",
            description: "Talleres, trivia, stand ups y aventuras al aire libre.",
            members: 445,
            category: "Actividades",
            isJoined: false,
            posts: [],
            hosts: [
                Host(name: "Laura Castillo", emoji: "👑", role: .admin, university: "UP")
            ]
        ),
        Community(
            name: "Talks",
            emoji: "🎤",
            description: "Podcast universitario, charlas y conversaciones que inspiran.",
            members: 334,
            category: "Cultura",
            isJoined: false,
            posts: [],
            hosts: [
                Host(name: "Gabriela Ramos", emoji: "👑", role: .admin, university: "USMA"),
                Host(name: "Nicolás Vega", emoji: "⭐", role: .coAdmin, university: "ULatina")
            ]
        ),
        Community(
            name: "Sorority",
            emoji: "🌸",
            description: "Comunidad exclusiva para mujeres universitarias.",
            members: 678,
            category: "Social",
            isJoined: false,
            posts: [],
            hosts: [
                Host(name: "Daniela Flores", emoji: "👑", role: .admin, university: "USMA"),
                Host(name: "Patricia Luna", emoji: "⭐", role: .coAdmin, university: "UP")
            ]
        )
    ]
}
