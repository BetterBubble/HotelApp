//
//  ProfileView.swift
//  HotelApp
//
//  Created by Александр Шульга on 01.04.2025.
//

import SwiftUI
import PhotosUI
import Supabase

struct ProfileView: View {
    @EnvironmentObject var session: UserSession
    @State private var newAvatar = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var isUploading = false

    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Avatar
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                if let avatarURL = session.avatarURL, let url = URL(string: avatarURL) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    .id(url)
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                }
            }
            .task(id: selectedItem) {
                guard let item = selectedItem,
                      let data = try? await item.loadTransferable(type: Data.self) else { return }

                selectedImageData = data
                await uploadAvatarToSupabase(data: data)
            }

            Text(session.userEmail ?? "Нет email")
                .font(.title2)

            Button("Выйти из аккаунта") {
                Task {
                    await session.logout()
                }
            }
            .foregroundColor(.red)

            Spacer()
        }
        .padding()
        .navigationTitle("Профиль")
    }
    
    func uploadAvatarToSupabase(data: Data) async {
        guard let userId = try? await session.client.auth.session.user.id else { return }
        
        let fileName = "\(userId)_avatar.jpg"
        let path = "private/\(userId)/\(fileName)"
        
        do {
            // Загрузка файла
            _ = try await session.client.storage
                .from("avatars")
                .upload(
                    path,
                    data: data,
                    options: FileOptions(
                        cacheControl: "3600",
                        contentType: "image/jpeg",
                        upsert: true
                    )
                )
            
            // 🔧 Собираем URL вручную
            let supabaseURL = "https://vxnhnzhqzxvmalhqlbci.supabase.co"
            let publicURL = "\(supabaseURL)/storage/v1/object/public/avatars/\(path)"
            
            // Обновляем user_metadata
            try await session.client.auth.update(user: .init(data: [
                "avatar_url": .string(publicURL)
            ]))
            
            try await session.checkSession()
            
            await MainActor.run {
                self.session.avatarURL = publicURL
            }
            
        } catch {
            print("❌ Ошибка загрузки аватара:", error)
            print("Тип ошибки:", type(of: error))
        }
    }
    
}

#Preview {
    ProfileView()
        .environmentObject(UserSession())
}
