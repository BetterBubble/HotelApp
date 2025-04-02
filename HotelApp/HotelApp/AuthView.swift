//
//  AuthView.swift
//  HotelApp
//
//  Created by Александр Шульга on 01.04.2025.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var session: UserSession

    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            SecureField("Пароль", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button(action: {
                Task {
                    do {
                        if isRegistering {
                            try await session.register(email: email, password: password)
                        } else {
                            try await session.login(email: email, password: password)
                        }
                    } catch {
                        errorMessage = error.localizedDescription
                    }
                }
            }) {
                Text(isRegistering ? "Зарегистрироваться" : "Войти")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Button(isRegistering ? "Уже есть аккаунт? Войти" : "Нет аккаунта? Зарегистрироваться") {
                isRegistering.toggle()
                errorMessage = ""
            }
            .font(.footnote)
            .padding(.top)
        }
        .padding()
        .navigationTitle(isRegistering ? "Регистрация" : "Вход")
    }
}

#Preview {
    AuthView()
        .environmentObject(UserSession())
}
