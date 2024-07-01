//
//  ApplicationSwitcher.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 1/7/24.
//

import Foundation

import SwiftUI
import RealmSwift

struct ApplicationSwitcher: View {
    @ObservedObject var app: RealmSwift.App
    @EnvironmentObject var errorHandler: ErrorHandler

    var body: some View {
        if let user = app.currentUser {
            let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                if let _ = subs.first(named: Constants.allItems) {
                    return
                } else {
                    subs.append(QuerySubscription<RealmNote>(name: Constants.allItems))
                }
            })
            OpenRealmView(user: user)
                // Store configuration in the environment to be opened in next view
                .environment(\.realmConfiguration, config)
        } else {

            Button {
                Task {
                    await login()
                }
            } label: {
                Text("Log in")
            }
        }
    }
    
    /// Logs in with an existing user.
    func login() async {
        do {
            let user = try await app.login(credentials: .anonymous)
            print("Successfully logged in user: \(user)")
        } catch {
            print("Failed to log in user: \(error.localizedDescription)")
            errorHandler.error = error
        }
    }
}
