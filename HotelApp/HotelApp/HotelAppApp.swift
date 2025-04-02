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
                NavigationStack {
                    RoomListView()
                }
                .environmentObject(session)
            } else {
                NavigationStack {
                    AuthView()
                }
                .environmentObject(session)
            }
        }
    }
}
