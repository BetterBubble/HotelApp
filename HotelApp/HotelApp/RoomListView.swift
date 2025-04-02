//
//  RoomListView.swift
//  HotelApp
//
//  Created by Александр Шульга on 01.04.2025.
//

import SwiftUI

struct RoomListView: View {
    @StateObject private var viewModel = RoomViewModel()
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            VStack {
                filterPicker

                if viewModel.isLoading {
                    loadingView
                } else if viewModel.rooms.isEmpty {
                    emptyStateView
                } else {
                    roomList
                }
            }
            .navigationTitle("Номера гостиницы")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showProfile = true
                    } label: {
                        Image(systemName: "person.circle")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
        }
        .task {
            await viewModel.fetchRooms()
        }
        .onChange(of: viewModel.filter) {
            Task {
                await viewModel.fetchRooms()
            }
        }
    }

    // MARK: - Components

    private var filterPicker: some View {
        Picker("Фильтр", selection: $viewModel.filter) {
            Text("Все").tag(RoomFilterType.all)
            Text("Свободные").tag(RoomFilterType.available)
            Text("Занятые").tag(RoomFilterType.occupied)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }

    private var loadingView: some View {
        ProgressView("Загрузка номеров...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var emptyStateView: some View {
        Text("Нет номеров по выбранному фильтру")
            .foregroundColor(.secondary)
            .font(.headline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var roomList: some View {
        List(viewModel.rooms) { room in
            NavigationLink(destination: RoomDetailView(room: room)) {
                HStack(alignment: .top, spacing: 12) {
                    AsyncImage(url: URL(string: room.imageURLs.first ?? "")) { image in
                        image.resizable()
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
                        Text(room.name).font(.headline)
                        Text(room.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text("Цена: \(Int(room.price))₽")
                            .font(.footnote)
                            .foregroundColor(.secondary)

                        if room.isAvailable {
                            Text("🟢 Свободен")
                                .font(.caption)
                                .foregroundColor(.green)
                        } else {
                            Text("🔴 Занят")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    RoomListView()
}
