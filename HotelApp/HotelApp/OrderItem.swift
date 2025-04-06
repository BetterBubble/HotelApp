//
//  OrderItem.swift
//  HotelApp
//
//  Created by Александр Шульга on 05.04.2025.
//

import Foundation

struct OrderItem: Codable, Identifiable {
    let id: UUID
    let orderId: UUID
    let dishId: UUID
    let quantity: Int
}
