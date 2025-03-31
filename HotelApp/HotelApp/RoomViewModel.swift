//
//  RoomViewModel.swift
//  HotelApp
//
//  Created by Александр Шульга on 01.04.2025.
//

import Foundation

@MainActor
class RoomViewModel: ObservableObject {
    @Published var rooms: [Room] = []
    @Published var isLoading = false

    func fetchAvailableRooms() async {
        isLoading = true
        do {
            let response: [Room] = try await SupabaseManager.shared.client
                .from("rooms")
                .select()
                .eq("is_available", value: true)
                .execute()
                .value
            self.rooms = response
        } catch {
            print("Ошибка при получении номеров: \(error)")
        }
        isLoading = false
    }
}
