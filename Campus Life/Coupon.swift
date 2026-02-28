//
//  Coupon.swift
//  Campus Life
//
//  Created by Richard Edmundo on 02/27/26.
//

import Foundation

struct Coupon: Identifiable {
    let id = UUID()
    let businessName: String
    let businessCategory: String
    let businessEmoji: String
    let discount: String
    let description: String
    let validUntil: String
    let location: String
    let instagramHandle: String
    let websiteURL: String
    let menuImages: [String]
    let localImages: [String]
    let latitude: Double
    let longitude: Double
    let isDownloaded: Bool
    let termsAndConditions: String
}

extension Coupon {
    static let sampleCoupons: [Coupon] = [
        Coupon(
            businessName: "Tacos La Neta",
            businessCategory: "Restaurante Mexicano",
            businessEmoji: "🌮",
            discount: "20% OFF",
            description: "Disfruta un 20% de descuento en toda tu orden. Válido para estudiantes universitarios verificados.",
            validUntil: "31 Mar 2026",
            location: "Casco Antiguo, Panamá",
            instagramHandle: "@tacoslaneta",
            websiteURL: "tacoslaneta.com",
            menuImages: ["🌮", "🌯", "🫔"],
            localImages: ["🏪", "🍽️", "✨"],
            latitude: 8.9936,
            longitude: -79.5197,
            isDownloaded: false,
            termsAndConditions: "Válido solo con ID Campus Life verificado. No combinable con otras promociones. Una vez por semana por estudiante."
        ),
        Coupon(
            businessName: "Café Unido",
            businessCategory: "Cafetería",
            businessEmoji: "☕",
            discount: "2x1",
            description: "Lleva dos bebidas al precio de una. Aplica a toda la línea de cafés y frappés.",
            validUntil: "15 Apr 2026",
            location: "Marbella, Panamá",
            instagramHandle: "@cafeunido",
            websiteURL: "cafeunido.com",
            menuImages: ["☕", "🧋", "🍰"],
            localImages: ["🏠", "☕", "📚"],
            latitude: 8.9824,
            longitude: -79.5199,
            isDownloaded: false,
            termsAndConditions: "Válido solo con ID Campus Life verificado. Aplica de lunes a viernes. Máximo una vez al día por estudiante."
        ),
        Coupon(
            businessName: "Sport Zone",
            businessCategory: "Ropa Deportiva",
            businessEmoji: "👟",
            discount: "15% OFF",
            description: "15% de descuento en toda la tienda. Ropa, calzado y accesorios deportivos.",
            validUntil: "30 Apr 2026",
            location: "Multiplaza, Panamá",
            instagramHandle: "@sportzonepanama",
            websiteURL: "sportzone.com.pa",
            menuImages: ["👟", "👕", "🎽"],
            localImages: ["🏪", "👟", "🏆"],
            latitude: 8.9940,
            longitude: -79.5220,
            isDownloaded: false,
            termsAndConditions: "Válido solo con ID Campus Life verificado. No aplica a productos en oferta. Una vez por mes por estudiante."
        )
    ]
}
