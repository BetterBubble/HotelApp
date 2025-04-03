//
//  HotelAppApp.swift
//  HotelApp
//
//  Created by Александр Шульга on 31.03.2025.
//

import SwiftUI

@main
struct HotelAppApp: App {
    @StateObject var session = UserSession()

    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                TabView {
                    RoomListView()
                        .tabItem {
                            Label("Номера", systemImage: "bed.double")
                        }

                    MenuView()
                        .tabItem {
                            Label("Меню", systemImage: "fork.knife")
                        }

                    ProfileView()
                        .tabItem {
                            Label("Профиль", systemImage: "person.circle")
                        }
                }
                .environmentObject(session)
            } else {
                AuthView()
                    .environmentObject(session)
            }
        }
    }
}
