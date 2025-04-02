//
//  RoomDetailView.swift
//  HotelApp
//
//  Created by Александр Шульга on 01.04.2025.
//

import SwiftUI

struct RoomDetailView: View {
    let room: Room

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                imageCarousel

                VStack(alignment: .leading, spacing: 8) {
                    Text(room.name)
                        .font(.title)
                        .bold()

                    Text(room.description)
                        .font(.body)
                        .foregroundColor(.secondary)

                    if let area = room.area {
                        Text("Площадь: \(Int(area)) м²")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Text("Цена: \(Int(room.price))₽")
                        .font(.title3)
                        .bold()

                    if room.isAvailable {
                        Label("Свободен", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    } else {
                        Label("Занят", systemImage: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)

                featureSection(title: "Оснащение комнаты", items: room.roomFeatures)
                featureSection(title: "Оснащение ванной", items: room.bathFeatures)
                featureSection(title: "Прочее оснащение", items: room.otherFeatures)
            }
        }
        .navigationTitle("Информация о номере")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Image carousel
    private var imageCarousel: some View {
        TabView {
            ForEach(room.imageURLs, id: \.self) { urlString in
                if let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                    }
                    .frame(height: 220)
                    .clipped()
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 220)
    }

    // MARK: - Feature block
    private func featureSection(title: String, items: [String]) -> some View {
        if items.isEmpty {
            return AnyView(EmptyView())
        }

        return AnyView(
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)

                ForEach(items, id: \.self) { item in
                    Label(item, systemImage: "checkmark.circle")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }

                Divider()
            }
            .padding(.horizontal)
        )
    }
}
