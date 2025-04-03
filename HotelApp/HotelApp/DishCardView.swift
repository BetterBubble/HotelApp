//
//  DishCardView.swift
//  HotelApp
//
//  Created by Александр Шульга on 03.04.2025.
//

import SwiftUI

struct DishCardView: View {
    let dish: Dish

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
        }
        .padding()
        .background(.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}
