//
//  Room.swift
//  HotelApp
//
//  Created by Александр Шульга on 01.04.2025.
//

import Foundation

struct Room: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let price: Double
    let is_available: Bool
    let image_url: String
}
