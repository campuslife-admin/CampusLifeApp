//
//  Event.swift
//  Campus Life
//
//  Created by Richard Edmundo on 02/24/26.
//

import Foundation

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let organizer: String
    let category: EventCategory
    let date: String
    let time: String
    let location: String
    let price: Double
    let isFree: Bool
    let emoji: String
    let attendees: Int
    let capacity: Int
    let description: String
}

enum EventCategory {
    case nightlife
    case sports
    case trips
    case tech
    case food
    case fitness
}

extension Event {
    static let sampleEvents: [Event] = [
        Event(
            title: "FURIA | ON CAMPUS RELOADED",
            organizer: "Campus Life",
            category: .nightlife,
            date: "Sáb 26 Feb",
            time: "10:00 PM",
            location: "Furia Panamá",
            price: 15.00,
            isFree: false,
            emoji: "🌙",
            attendees: 234,
            capacity: 500,
            description: "La fiesta universitaria más grande de Panamá regresa con todo. Música, ambiente y la mejor vibra campus."
        ),
        Event(
            title: "Pasadía Pozos Azules",
            organizer: "Trips Campus",
            category: .trips,
            date: "Sáb 14 Mar",
            time: "7:00 AM",
            location: "Pozos Azules, Panamá",
            price: 45.00,
            isFree: false,
            emoji: "✈️",
            attendees: 45,
            capacity: 60,
            description: "Un día de aventura en las piscinas naturales más hermosas de Panamá. Incluye transporte y guía."
        ),
        Event(
            title: "Taller de Inteligencia Artificial",
            organizer: "Tech & AI Campus",
            category: .tech,
            date: "Vie 6 Mar",
            time: "6:00 PM",
            location: "Online — Zoom",
            price: 0,
            isFree: true,
            emoji: "🤖",
            attendees: 128,
            capacity: 200,
            description: "Aprende a usar las herramientas de IA más poderosas para potenciar tu carrera universitaria."
        ),
        Event(
            title: "Torneo de Fútbol Universitario",
            organizer: "Sports Campus",
            category: .sports,
            date: "Dom 8 Mar",
            time: "9:00 AM",
            location: "Estadio UTP",
            price: 5.00,
            isFree: false,
            emoji: "⚽",
            attendees: 89,
            capacity: 150,
            description: "El torneo más competitivo entre universidades de Panamá. Inscribe tu equipo y demuestra de qué estás hecho."
        ),
        Event(
            title: "Chill Out Viernes",
            organizer: "Nightlife Campus",
            category: .nightlife,
            date: "Vie 27 Feb",
            time: "9:00 PM",
            location: "Chillout, Downtown Amador",
            price: 10.00,
            isFree: false,
            emoji: "🎉",
            attendees: 167,
            capacity: 300,
            description: "El mejor cierre de semana universitario. Música, drinks y la mejor gente del campus."
        )
    ]
}
