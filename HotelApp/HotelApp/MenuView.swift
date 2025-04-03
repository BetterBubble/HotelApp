//
//  MenuView.swift
//  HotelApp
//
//  Created by Александр Шульга on 03.04.2025.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel = DishViewModel()

    var body: some View {
        NavigationView {
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
        }
    }
}

