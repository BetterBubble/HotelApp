//
//  Room.swift
//  HotelApp
//
//  Created by Александр Шульга on 01.04.2025.
//

import Foundation

struct Room: Identifiable, Decodable {
    let id: UUID
    let name: String
    let description: String
    let price: Double
    let isAvailable: Bool
    let imageURLs: [String]
    let area: Double?
    let roomFeatures: [String]
    let bathFeatures: [String]
    let otherFeatures: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, description, price, isAvailable = "is_available",
             imageURLs = "image_urls",
             area,
             roomFeatures = "room_features",
             bathFeatures = "bath_features",
             otherFeatures = "other_features"
    }
}
