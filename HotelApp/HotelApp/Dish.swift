//
//  Dish.swift
//  HotelApp
//
//  Created by Александр Шульга on 03.04.2025.
//

import Foundation

struct Dish: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let price: Int
    let ingredients: [String]
    let calories: Int
    let bju: [Int] // [белки, жиры, углеводы]
    let image_url: String
    let category: String
    let created_at: String
}
