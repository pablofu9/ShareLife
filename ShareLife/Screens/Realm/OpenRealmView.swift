//
//  OpenRealmView.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 1/7/24.
//

import Foundation

import SwiftUI
import RealmSwift

/// Called when login completes. Opens the realm and navigates to the Items screen.
struct OpenRealmView: View {
    @AutoOpen(appId: theAppConfig.appId, timeout: 2000) var autoOpen
    // We must pass the user, so we can set the user.id when we create Item objects
    @State var user: User
    @State var isInOfflineMode = false
    // Configuration used to open the realm.
    @Environment(\.realmConfiguration) private var config

    var body: some View {
        switch autoOpen {
        case .connecting:
            // Starting the Realm.autoOpen process.
            // Show a progress view.
            ProgressView()
        case .waitingForUser:
            // Waiting for a user to be logged in before executing
            // Realm.asyncOpen.
            ProgressView("Waiting for user to log in...")
        case .open(_):

            MainView(user: user)

        case .progress(let progress):
            // The realm is currently being downloaded from the server.
            // Show a progress view.
            ProgressView(progress)
        case .error(let error):
            // Opening the Realm failed.
            // Show an error view.
            ProgressView(error.localizedDescription)
        }
    }
}
