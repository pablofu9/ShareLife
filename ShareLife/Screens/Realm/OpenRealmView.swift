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
           LoadingView()
        case .waitingForUser:
            // Waiting for a user to be logged in before executing
            // Realm.asyncOpen.
            LoadingView()
        case .open(_):

            MainView(user: user)

        case .progress(_):
            // The realm is currently being downloaded from the server.
            // Show a progress view.
            LoadingView()
        case .error(_):
            // Opening the Realm failed.
            // Show an error view.
            LoadingView()
        }
    }
}
