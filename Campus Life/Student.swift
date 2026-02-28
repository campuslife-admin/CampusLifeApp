//
//  Student.swift
//  Campus Life
//
//  Created by Richard Edmundo on 02/27/26.
//

import Foundation

struct Student {
    let name: String
    let university: String
    let major: String
    let studentID: String
    let avatarEmoji: String
    let year: String
    let communities: [String]
    let ticketsCount: Int
    let couponsCount: Int
    let eventsAttended: Int
}

extension Student {
    static let sampleStudent = Student(
        name: "Richard Edmundo",
        university: "Universidad Tecnológica de Panamá",
        major: "Ingeniería en Sistemas",
        studentID: "CL-2024-00142",
        avatarEmoji: "👨‍💻",
        year: "3er año",
        communities: ["Nightlife", "Fitness", "Tech & AI"],
        ticketsCount: 4,
        couponsCount: 7,
        eventsAttended: 12
    )
}
