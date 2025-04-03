//
//  DishViewModel.swift
//  HotelApp
//
//  Created by Александр Шульга on 03.04.2025.
//

import Foundation
import Supabase

@MainActor
class DishViewModel: ObservableObject {
    @Published var dishes: [Dish] = []
    @Published var selectedCategory: String = "Все"

    let categories = ["Все", "Завтрак", "Обед", "Ужин"]

    func fetchDishes() async {
        do {
            let client = SupabaseManager.shared.client
            let query = client
                .from("dishes")
                .select()

            let response: [Dish] = try await query.execute().value
            self.dishes = response
        } catch {
            print("Ошибка загрузки блюд:", error)
        }
    }

    var filteredDishes: [Dish] {
        if selectedCategory == "Все" {
            return dishes
        } else {
            return dishes.filter { $0.category.lowercased() == selectedCategory.lowercased() }
        }
    }
}
