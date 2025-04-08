//
//  OrderConfirmationView.swift
//  HotelApp
//
//  Created by Александр Шульга on 05.04.2025.
//

import SwiftUI
import Supabase

struct OrderConfirmationView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var session: UserSession
    @Environment(\.dismiss) private var dismiss

    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var showOrderSuccess = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Выберите дату и время трапезы")
                .font(.headline)

            DatePicker("Дата", selection: $selectedDate, in: allowedDates, displayedComponents: .date)
                .datePickerStyle(.graphical)

            DatePicker("Время", selection: $selectedTime, in: allowedTimes, displayedComponents: .hourAndMinute)
            
            let totalPrice = cartManager.items.reduce(0) { $0 + ($1.dish.price * $1.quantity) }
            Text("Итого к оплате: \(totalPrice) ₽")
                .font(.title2)
                .bold()
                .padding()
            
            Button(action: placeOrder) {
                Text("Подтвердить заказ")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            .alert("✅ Заказ оформлен!", isPresented: $showOrderSuccess) {
                Button("Ок") {
                    cartManager.clear()
                    dismiss()
                }
            } message: {
                Text("Ваш заказ успешно оформлен и отправлен на кухню.")
            }
        }
        .padding()
        .navigationTitle("Оформление заказа")
    }

    // Разрешённые даты: сегодня и завтра
    private var allowedDates: ClosedRange<Date> {
        let today = Calendar.current.startOfDay(for: Date())
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        return today...tomorrow
    }

    // Разрешённое время: 08:00 — 22:00
    private var allowedTimes: ClosedRange<Date> {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current

        let now = Date()
        let eightAM = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: now)!
        let tenPM = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: now)!

        return eightAM...tenPM
    }

    private func placeOrder() {
        // Проверим, достаточно ли времени до приёма пищи
        let minTime = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        let selectedDateTime = Calendar.current.date(
            bySettingHour: Calendar.current.component(.hour, from: selectedTime),
            minute: Calendar.current.component(.minute, from: selectedTime),
            second: 0,
            of: selectedDate
        )!

        guard selectedDateTime >= minTime else {
            print("❌ Слишком рано! Минимум за час до времени трапезы.")
            return
        }

        Task {
            do {
                try await createOrder(date: selectedDate, time: selectedTime)
                cartManager.clear()
                dismiss()
                showOrderSuccess = true
                print("✅ Заказ успешно создан!")
            } catch {
                print("Session userID:", session.userID)
                print("❌ Ошибка создания заказа:", error.localizedDescription)
            }
        }
    }

    private func createOrder(date: Date, time: Date) async throws {
        let client = SupabaseManager.shared.client

        // Форматируем дату и время
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"

        let mealDate = dateFormatter.string(from: date)
        let mealTime = timeFormatter.string(from: time)

        // Создаём заказ
        let insertResponse = try await client
            .from("orders")
            .insert([
                "user_id": session.userID,
                "meal_date": mealDate,
                "meal_time": mealTime
            ], returning: .representation)
            .select("id")
            .single()
            .execute()

        // Проверяем ответ и вытаскиваем ID
        guard let rows = insertResponse.value as? [[String: Any]],
              let idString = rows.first?["id"] as? String,
              let orderId = UUID(uuidString: idString) else {
            print("❌ Не удалось получить ID заказа")
            return
        }
        // Добавляем все блюда из корзины
        for item in cartManager.items {
            print("orderId: \(orderId), dishId: \(item.dish.id), quantity: \(item.quantity)")
            print(type(of: item.dish.id))
            try await client
                .from("order_items")
                .insert([
                    "order_id": orderId.uuidString,
                    "dish_id": item.dish.id.uuidString,
                    "quantity": String(item.quantity)
                ])
                .execute()
        }
    }
}
