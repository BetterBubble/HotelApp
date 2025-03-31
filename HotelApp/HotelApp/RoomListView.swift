//
//  RoomListView.swift
//  HotelApp
//
//  Created by Александр Шульга on 01.04.2025.
//

import SwiftUI

struct RoomListView: View {
    @StateObject private var viewModel = RoomViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Загрузка номеров...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.rooms.isEmpty {
                    Text("Нет доступных номеров")
                        .foregroundColor(.secondary)
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.rooms) { room in
                        HStack(alignment: .top, spacing: 12) {
                            AsyncImage(url: URL(string: room.image_url)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(8)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(8)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(room.name)
                                    .font(.headline)
                                Text(room.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Цена: \(Int(room.price))₽")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Свободные номера")
        }
        .task {
            await viewModel.fetchAvailableRooms()
        }
    }
}

#Preview {
    RoomListView()
}
