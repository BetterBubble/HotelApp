//
//  CartView.swift
//  HotelApp
//
//  Created by Александр Шульга on 05.04.2025.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var session: UserSession
    @State private var isOrderPlaced = false

    var body: some View {
        VStack {
            if cartManager.items.isEmpty {
                Text("🧺 Корзина пуста")
                    .font(.title2)
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(cartManager.items) { item in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.dish.name)
                                    .font(.headline)

                                Text("Количество: \(item.quantity)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Text("\(item.dish.price * item.quantity) ₽")
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                HStack {
                    Text("Итого:")
                        .font(.headline)
                    Spacer()
                    Text(cartManager.totalPrice.formatted(.currency(code: "RUB")))
                        .font(.headline)
                }
                .padding()

                NavigationLink(destination: OrderConfirmationView()
                    .environmentObject(cartManager)
                    .environmentObject(session)
                ){
                    Text("Оформить заказ")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .padding(.bottom)
            }
            
        }
        .navigationTitle("Корзина")
        
    }

    private func removeItems(at offsets: IndexSet) {
        cartManager.items.remove(atOffsets: offsets)
    }
    
}
