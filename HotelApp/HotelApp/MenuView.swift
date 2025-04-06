//
//  MenuView.swift
//  HotelApp
//
//  Created by Александр Шульга on 03.04.2025.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel = DishViewModel()
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Категория", selection: $viewModel.selectedCategory) {
                    ForEach(viewModel.categories, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.filteredDishes) { dish in
                            DishCardView(dish: dish)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Меню")
            .task {
                await viewModel.fetchDishes()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartView()) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart")
                                .font(.title2)

                            if cartManager.items.count > 0 {
                                Text("\(cartManager.items.reduce(0) { $0 + $1.quantity })")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 10, y: -10)
                            }
                        }
                    }
                }
            }
        }
    }
}

