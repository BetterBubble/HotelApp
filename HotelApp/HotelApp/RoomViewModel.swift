//
//  RoomViewModel.swift
//  HotelApp
//
//  Created by Александр Шульга on 01.04.2025.
//

import Foundation

enum RoomFilterType {
    case all, available, occupied
}

@MainActor
class RoomViewModel: ObservableObject {
    @Published var rooms: [Room] = []
    @Published var isLoading = false
    @Published var filter: RoomFilterType = .available

    func fetchRooms() async {
        isLoading = true
        do {
            var query = SupabaseManager.shared.client.from("rooms").select()

            switch filter {
            case .available:
                query = query.eq("is_available", value: true)
            case .occupied:
                query = query.eq("is_available", value: false)
            case .all:
                break
            }

            let response: [Room] = try await query.execute().value
            self.rooms = response
        } catch {
            print("Ошибка при загрузке номеров: \(error)")
        }
        isLoading = false
    }
}
