//
//  ShareLifeApp.swift
//  ShareLife
//
//  Created by Pablo Fuertes on 29/6/24.
//

import SwiftUI
import RealmSwift

@main
struct ShareLifeApp: SwiftUI.App {
    var config = Realm.Configuration.defaultConfiguration
    
    init() {
        #if DEBUG
        config.deleteRealmIfMigrationNeeded = true
        #endif
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.realmConfiguration, config)
        }
    }
}
