//
//  CartManager.swift
//  HotelApp
//
//  Created by Александр Шульга on 05.04.2025.
//

import Foundation

@MainActor
class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var selectedDate = Date()
    
    // Добавить блюдо в корзину
    func add(_ dish: Dish) {
        if let index = items.firstIndex(where: { $0.dish.id == dish.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(dish: dish, quantity: 1))
        }
    }
    
    // Удалить блюдо из корзины
    func remove(_ dish: Dish) {
        items.removeAll { $0.dish.id == dish.id }
    }
    
    // Очистить корзину
    func clear() {
        items.removeAll()
    }
    
    // Проверка: можно ли оформить заказ (есть ли блюда в корзине)
    var canPlaceOrder: Bool {
        !items.isEmpty
    }
    
    //Подсчет суммы заказа блюд
    var totalPrice: Int {
        items.reduce(0) { result, item in
            result + (item.dish.price * item.quantity)
        }
    }
}

struct CartItem: Identifiable {
    let id = UUID()
    let dish: Dish
    var quantity: Int
}
