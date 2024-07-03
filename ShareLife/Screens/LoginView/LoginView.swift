//
//  LoginView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 3/7/24.
//

import SwiftUI
import Lottie
import RealmSwift

struct LoginView: View {
    
    // MARK: PROPERTIES
    
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var app: RealmSwift.App
    @EnvironmentObject var errorHandler: ErrorHandler

    
    // MARK: BODY
    
    var body: some View {
        ZStack {
            Color.customWhiteColor.opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                loginTitle
                formView
                loginButton
                    .padding(.top, 20)
                Spacer()
            }

            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(bgLottie)
        }
    }
}

extension LoginView {
    
    // MARK: SUBVIEWS
    
    @ViewBuilder
    private var loginButton: some View {
        Button {
            Task {
                if !email.isEmpty && !password.isEmpty {
                    await login()
                }
            }
        } label: {
            Text("Log in")
                .frame(maxWidth: .infinity)
                .font(.custom(FontNames.kPoppinsMedium, size: 20))
                .padding(.horizontal, 30)
                .foregroundStyle(Color.customWhiteColor)
                .padding(.vertical, 10)
                .background(Color.customBrownColor)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
  
        }
        .disabled(email.isEmpty || password.isEmpty)
        .padding(.horizontal, 20)
        .shadow(
            color: .black.opacity(0.8),
            radius: 3,
            x: 2,
            y: 2
        )
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    private var formView: some View {
        VStack(spacing: 0) {
            Text("EMAIL")
                .font(.custom(FontNames.kPoppinsSemiBold, size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            TextField("Email", text: $email)
                .textFieldStyle(LoginTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
        }
        .padding(.vertical, 20)
        VStack(spacing: 0){
            Text("PASSWORD")
                .font(.custom(FontNames.kPoppinsSemiBold, size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            SecureField("Password", text: $password)
                .textFieldStyle(LoginTextFieldStyle())
                .autocorrectionDisabled()
                .keyboardType(.default)
        }
        
        if let _ = errorHandler.error {
            wrongCredentials
        }
    }
    
    @ViewBuilder
    private var bgLottie: some View {
        LottieView(animation: .named("bg"))
            .resizable()
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var loginTitle: some View {
        Text("Log into your account")
            .font(.custom(FontNames.kPoppinsSemiBold, size: 20))
    }
    
    @ViewBuilder
    private var wrongCredentials: some View {
        Text("Credenciales incorrectas")
            .font(.custom(FontNames.kPoppinsRegular, size: 15))
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
    }
}

extension LoginView {
    
    /// Logs in with an existing user.
    func login() async {
        do {
            let user = try await app.login(credentials: .emailPassword(email: email, password: password))
            print("Successfully logged in user: \(user)")
        } catch {
            print("Failed to log in user: \(error.localizedDescription)")
            errorHandler.error = error
            
        }
    }
}

#Preview {
    LoginView(app: App(id: "asds"))
}
