//
//  DishCardView.swift
//  HotelApp
//
//  Created by Александр Шульга on 03.04.2025.
//

import SwiftUI

struct DishCardView: View {
    let dish: Dish
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: dish.image_url)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 180)
                    .cornerRadius(10)
            }

            Text(dish.name)
                .font(.headline)

            Text(dish.description)
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Text("🍽 \(dish.calories) ккал")
                Spacer()
                Text("\(dish.price)₽")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            
            //добавление в корзину блюд в меню
            Button(action: {
                cartManager.add(dish)
            }) {
                HStack {
                    Image(systemName: "cart.badge.plus")
                    Text("Добавить в корзину")
                }
                .font(.footnote)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}
