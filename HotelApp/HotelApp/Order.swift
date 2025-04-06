//
//  Order.swift
//  HotelApp
//
//  Created by Александр Шульга on 05.04.2025.
//

import Foundation

struct Order: Codable, Identifiable {
    let id: UUID
    let userId: UUID
    let mealDate: String
    let mealTime: String
    let status: String?
    let createdAt: String?
    
}
