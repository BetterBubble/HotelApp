import Foundation
import Supabase

final class UserSession: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userEmail: String?
    @Published var avatarURL: String?

    let client = SupabaseManager.shared.client

    func register(email: String, password: String) async throws {
        _ = try await client.auth.signUp(
            email: email,
            password: password
        )
        try await checkSession()
    }

    func login(email: String, password: String) async throws {
        _ = try await client.auth.signIn(
            email: email,
            password: password
        )
        try await checkSession()
    }

    func logout() async {
        try? await client.auth.signOut()
        await MainActor.run {
            self.isLoggedIn = false
            self.userEmail = nil
            self.avatarURL = nil
        }
    }

    func checkSession() async throws {
        let session = try await client.auth.session

        await MainActor.run {
            self.userEmail = session.user.email
            if case let .string(url) = session.user.userMetadata["avatar_url"] {
                self.avatarURL = url
            }
            self.isLoggedIn = true
        }
    }
}
